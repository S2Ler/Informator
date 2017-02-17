//  Created by Alexander Belyavskiy on 2/17/17.

import Foundation

internal struct FIFOQueue<T> {
  private var popQueue: [T] = []
  private var pushQueue: [T] = []

  public init() {
    
  }

  public mutating func push(_ value: T) {
    pushQueue.append(value)
  }

  public mutating func pop() -> T? {
    if popQueue.count == 0 && pushQueue.count > 0 {
      movePushQueueToPopQueue()
    }

    return popQueue.popLast()
  }

  private mutating func movePushQueueToPopQueue() {
    while let next = pushQueue.popLast() {
      popQueue.append(next)
    }
  }
}
