import Foundation

public actor Informator<Presentor: InformatorPresenter>: @unchecked Sendable {
  private let presentor: Presentor

  private var queue: FIFOQueue<InformatorRequest>
  private var currentRequest: InformatorRequest?

  public init(presentor: Presentor) {
    self.presentor = presentor
    self.queue = FIFOQueue()
  }

  public func execute(_ request: InformatorRequest) async {
    queue.push(request)
    await processNextRequestIfNeeded()
  }

  private func processNextRequestIfNeeded() async {
    guard currentRequest == nil,
      let nextRequest = queue.pop() else { return }

    currentRequest = nextRequest

    await presentor.execute(nextRequest)
    currentRequest = nil
    await processNextRequestIfNeeded()
  }
}
