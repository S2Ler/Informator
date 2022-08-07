import Foundation

/// Wraps error to be compatible with Informator
public struct MessageableError: Messageable {
  private let error: Swift.Error
  private let title: String

  public init(from error: Swift.Error, title: String? = nil) {
      self.error = error
      self.title = title ?? NSLocalizedString("Error", comment: "")
  }

  public var messageTitle: String {
    title
  }

  public var messageBody: String {
    return error.localizedDescription
  }
}

public extension Swift.Error {
  func toMessageable() -> Messageable {
    return MessageableError(from: self)
  }
}

/// Simple Message compatible with Informator
public struct Message: Messageable {
  let title: String
  let body: String

  public init(title: String, body: String) {
    self.title = title
    self.body = body
  }

  public var messageTitle: String { return title }
  public var messageBody: String { return body }
}

// MARK: - Swift 5.5 features
#if swift(>=5.5)
extension Messageable where Self == MessageableError {
    public static func error(
        from error: Error,
        title: String? = nil
    ) -> MessageableError {
      .init(from: error, title: title)
  }
}

extension Messageable where Self == Message {
    public static func message(
        title: String,
        body: String
    ) -> Message {
      .init(title: title, body: body)
  }
}
#endif
