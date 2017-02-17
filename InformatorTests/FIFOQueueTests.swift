//  Created by Alexander Belyavskiy on 2/17/17.

import XCTest
@testable import Informator

class FIFOQueueTests: XCTestCase {
  func testEmpty() {
    var queue = FIFOQueue<Int>()
    XCTAssertNil(queue.pop())
  }

  func testPushPop() {
    var queue = FIFOQueue<Int>()
    queue.push(1)
    XCTAssertEqual(queue.pop(), 1)
  }

  func testPushPops() {
    var queue = FIFOQueue<Int>()
    queue.push(1)
    queue.push(2)
    XCTAssertEqual(queue.pop(), 1)
    queue.push(3)
    XCTAssertEqual(queue.pop(), 2)
    queue.push(4)
    queue.push(5)
    XCTAssertEqual(queue.pop(), 3)
    XCTAssertEqual(queue.pop(), 4)
    XCTAssertEqual(queue.pop(), 5)
    XCTAssertNil(queue.pop())
  }
}
