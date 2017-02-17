//  Created by Alexander Belyavskiy on 2/17/17.

import Foundation

#if os(iOS)
  internal struct UIKitLocalization {
    public static func get(_ key: Key) -> String? {
      return Bundle(identifier: "com.apple.UIKit")?.localizedString(forKey: key.rawKey, value: nil, table: nil)
    }

    enum Key {
      case ok
      case cancel
      case done

      fileprivate var rawKey: String {
        switch self {
        case .ok:
          return "OK"
        case .cancel:
          return "Cancel"
        case .done:
          return "Done"
        }
      }
    }
  }
#endif
