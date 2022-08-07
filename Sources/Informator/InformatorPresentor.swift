import Foundation

public protocol InformatorPresenter: Sendable {
  func execute(_ request: InformatorRequest) async
}
