import Foundation

public protocol Messageable: Sendable {
  var messageTitle: String { get }
  var messageBody: String { get }
}
