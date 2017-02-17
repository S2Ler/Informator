//  Created by Alexander Belyavskiy on 2/17/17.

import XCTest
@testable import Informator

class InformatorTests: XCTestCase {

  func testBasics() {
    var requestCalledCount: Int = 0
    let informator = Informator(presentor: MockPresenter(handler: { _, completion in
      requestCalledCount += 1
      completion()
    }))

    informator.show(MockMessage(messageTitle: "", messageBody: ""))
    informator.show(MockMessage(messageTitle: "", messageBody: ""))
    XCTAssertEqual(requestCalledCount, 2)
  }

  func testQueue() {
    var requestCalledCount: Int = 0
    let informator = Informator(presentor: MockPresenter(handler: { _, completion in
      requestCalledCount += 1
    }))

    informator.show(MockMessage(messageTitle: "", messageBody: ""))
    informator.show(MockMessage(messageTitle: "", messageBody: ""))
    XCTAssertEqual(requestCalledCount, 1)
  }

  func testAsync() {
    let caseCount = 100
    var requestCalledCount: Int = 0

    let allRequestsExecuted = expectation(description: "allRequestsExecuted")

    let informator = Informator(presentor: MockPresenter(handler: { _, completion in
      requestCalledCount += 1
      DispatchQueue.global().async {
        completion()
        if requestCalledCount == caseCount {
          allRequestsExecuted.fulfill()
        }
      }
    }))

    for _ in 0..<caseCount {
      informator.show(MockMessage(messageTitle: "", messageBody: ""))
      informator.show(MockMessage(messageTitle: "", messageBody: ""))
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

}

fileprivate final class MockPresenter: InformatorPresenter {
  typealias Handler = (Informator<MockPresenter>.Request, _ completion: @escaping () -> Void) -> Void
  private let handler: Handler
  init(handler: @escaping Handler) {
    self.handler = handler
  }
  func execute(_ request: Informator<MockPresenter>.Request, completion: @escaping () -> Void) {
    handler(request, completion)
  }
}


