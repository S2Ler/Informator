import Foundation

public final class Informator<Presentor: InformatorPresenter> {
  private let presentor: Presentor

  private var queue: FIFOQueue<InformatorRequest>
  private var currentRequest: InformatorRequest?

  private let dispatchQueue = DispatchQueue(label: "Informator",
                                            qos: .userInitiated,
                                            target: DispatchQueue.global(qos: .userInitiated))

  public init(presentor: Presentor) {
    self.presentor = presentor
    queue = FIFOQueue()
  }

  public func execute(_ request: InformatorRequest) {
    dispatchQueue.sync {
      queue.push(request)
      processNextRequestIfNeeded()
    }
  }

  private func processNextRequestIfNeeded() {
    dispatchPrecondition(condition: .onQueue(dispatchQueue))

    guard currentRequest == nil,
      let nextRequest = queue.pop() else { return }

    self.currentRequest = nextRequest

    presentor.execute(nextRequest) { [weak self] in
      guard let this = self else { return }
      this.dispatchQueue.async {
        this.currentRequest = nil
        this.processNextRequestIfNeeded()
      }
    }
  }
}

public extension Informator {
  func show(_ message: Messageable) {
    let okAction = InformatorAction.okAction()
    execute(InformatorRequest(message: message, actions: [okAction]))
  }
}
