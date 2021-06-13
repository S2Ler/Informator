import XCTest
@testable import Informator

final class MessageableTests: XCTestCase {
#if swift(>=5.5)
  func testSwift_5_5_ErgonomicMethods() {
    enum AnError: LocalizedError {
      case anyError
      var errorDescription: String? { "anyError" }
    }
    let body = InformatorRequest(message: .error(from: AnError.anyError), actions: []).message.messageBody
    XCTAssertEqual(body, AnError.anyError.localizedDescription)
  }
#endif
}
