import Foundation

public final class InformatorAction {
  public let title: String
  public let style: Style
  private let handler: ((InformatorAction) -> Void)?

  public init(title: String, style: Style = .default, handler: ((InformatorAction) -> Void)?) {
    self.title = title
    self.style = style
    self.handler = handler
  }

  public enum Style {
    case `default`
    case cancel
    case destructive
  }

  public func invoke() {
    handler?(self)
  }

  public static func okAction(handler: ((InformatorAction) -> Void)? = nil) -> InformatorAction {
    return InformatorAction(title: UIKitLocalization.get(.ok) ?? "Ok", handler: handler)
  }
}
