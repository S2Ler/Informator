//  Created by Alexander Belyavskiy on 2/17/17.

import Foundation

public final class InformatorRequest {
  public let message: Messageable
  public let actions: [InformatorAction]

  public init(message: Messageable, actions: [InformatorAction] = []) {
    self.message = message
    self.actions = actions
  }
}
