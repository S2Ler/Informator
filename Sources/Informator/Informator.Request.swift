import Foundation

public struct InformatorRequest: Sendable {
  public struct UserInfoKey: Hashable, Sendable {
    public let rawValue: String

    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }
  }
  
  public let message: Messageable
  public let actions: [InformatorAction]
  public let userInfo: [UserInfoKey: Sendable]

  public init(
    message: Messageable,
    actions: [InformatorAction] = [],
    userInfo: [UserInfoKey: Sendable] = [:]
  ) {
    self.message = message
    self.actions = actions
    self.userInfo = userInfo
  }
}
