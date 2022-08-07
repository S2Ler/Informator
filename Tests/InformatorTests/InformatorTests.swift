import XCTest
@testable import Informator

class InformatorTests: XCTestCase {
  actor Values {
    var requestCalledCount: Int = 0
    func increaseRequestCalledCount() {
      requestCalledCount += 1
    }
  }

  func testBasics() async {
    let values: Values = .init()
    let informator = Informator(presentor: MockPresenter(handler: { _ in
      await values.increaseRequestCalledCount()
    }))

    await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
    await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
    let requestCalledCount = await values.requestCalledCount
    XCTAssertEqual(requestCalledCount, 2)
  }

  func testQueue() async  {
    let values: Values = .init()

    let informator = Informator(presentor: MockPresenter(handler: { _ in
      await values.increaseRequestCalledCount()
    }))

    await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
    Task.detached {
      await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
    }
    let requestCalledCount = await values.requestCalledCount
    XCTAssertEqual(requestCalledCount, 1)
  }

  func testAsync() async {
    let caseCount = 100
    let values: Values = .init()

    let allRequestsExecuted = expectation(description: "allRequestsExecuted")

    let informator = Informator(presentor: MockPresenter(handler: { _ in
      await values.increaseRequestCalledCount()
      await Task.detached {
        // no-op
      }.value

      Task.detached {
        if await values.requestCalledCount == caseCount {
          allRequestsExecuted.fulfill()
        }
      }
    }))

    for _ in 0..<caseCount {
      Task.detached {
        await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
      }
      Task.detached {
        await informator.execute(.init(message: MockMessage(messageTitle: "", messageBody: "")))
      }
    }

    await waitForExpectations(timeout: 1, handler: nil)
  }

  func testUserInfo() async {
    let key: String = "key"
    let value: String = "value"
    let requestCalled = expectation(description: "Request called")
    let informator = Informator(presentor: MockPresenter(handler: { r in
      XCTAssertEqual(r.userInfo[.init(key)] as! String, value)
      requestCalled.fulfill()
    }))
    let request = InformatorRequest(
      message: MockMessage(messageTitle: "", messageBody: ""),
      userInfo: [.init(key): value]
    )
    await informator.execute(request)
    await waitForExpectations(timeout: 1)
  }
}

fileprivate final class MockPresenter: InformatorPresenter {
  typealias Handler = @Sendable (InformatorRequest) async -> Void

  private let handler: Handler

  init(handler: @escaping Handler) {
    self.handler = handler
  }

  func execute(_ request: InformatorRequest) async {
    await handler(request)
  }
}


