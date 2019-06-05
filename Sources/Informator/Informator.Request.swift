import Foundation

public final class InformatorRequest {
  public let message: Messageable
  public let actions: [InformatorAction]

  public init(message: Messageable, actions: [InformatorAction] = []) {
    self.message = message
    self.actions = actions
  }
}
