import Foundation

public struct InformatorAction: Sendable {
  public let title: String
  public let style: Style
  private let handler: (@Sendable (InformatorAction) -> Void)?

  public init(title: String, style: Style = .default, handler: (@Sendable (InformatorAction) -> Void)?) {
    self.title = title
    self.style = style
    self.handler = handler
  }

  public enum Style: Sendable {
    case `default`
    case cancel
    case destructive
  }

  public func invoke() {
    handler?(self)
  }

  public static func okAction(handler: (@Sendable (InformatorAction) -> Void)? = nil) -> InformatorAction {
    return InformatorAction(title: AppLocalization.get(.ok) ?? "Ok", handler: handler)
  }
}
