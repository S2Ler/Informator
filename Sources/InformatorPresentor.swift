//  Created by Alexander Belyavskiy on 2/17/17.

import Foundation

public protocol InformatorPresenter {
  func execute(_ request: InformatorRequest, completion: @escaping () -> Void)
}
