//  Created by Alexander Belyavskiy on 2/17/17.

import Foundation

public protocol Messageable {
  var messageTitle: String { get }
  var messageBody: String { get }
}
