import Foundation

public protocol Messageable {
  var messageTitle: String { get }
  var messageBody: String { get }
}
