import Foundation

public protocol InformatorPresenter {
  func execute(_ request: InformatorRequest, completion: @escaping () -> Void)
}
