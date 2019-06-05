import Foundation

internal struct AppLocalization {
    public static func get(_ key: Key) -> String? {
        #if os(iOS) || os(tvOS)
        return Bundle(identifier: "com.apple.UIKit")?.localizedString(forKey: key.rawKey, value: nil, table: nil)
        #else
        return nil
        #endif
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
