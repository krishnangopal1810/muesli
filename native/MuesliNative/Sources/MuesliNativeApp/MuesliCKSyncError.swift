import Foundation

/// Errors surfaced by the iPhone/CloudKit synchronization flow.
///
/// Keep this type conforming to `LocalizedError`: passing a plain Swift error to
/// `NSError.localizedDescription` otherwise exposes the implementation detail
/// (`MuesliCKSyncError error 0`) to the user.
enum MuesliCKSyncError: Error, LocalizedError, Equatable {
    case iCloudUnavailable
    case networkUnavailable
    case syncFailed(message: String?)

    var errorDescription: String? {
        switch self {
        case .iCloudUnavailable:
            return "Sign in to iCloud in System Settings, then try syncing again."
        case .networkUnavailable:
            return "Muesli couldn’t reach iCloud. Check your internet connection and try again."
        case let .syncFailed(message):
            guard let message = message?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !message.isEmpty else {
                return "Muesli couldn’t sync with your iPhone. Try again in a moment."
            }
            return "Muesli couldn’t sync with your iPhone. \(message)"
        }
    }
}
