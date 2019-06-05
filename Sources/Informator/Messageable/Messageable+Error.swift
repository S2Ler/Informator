import Foundation

/// Wraps error to be compatible with Informator
public struct MessageableError: Messageable {
  private let error: Swift.Error

  public init(from error: Swift.Error) {
    self.error = error
  }

  public var messageTitle: String {
    return NSLocalizedString("Error", comment: "")
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
