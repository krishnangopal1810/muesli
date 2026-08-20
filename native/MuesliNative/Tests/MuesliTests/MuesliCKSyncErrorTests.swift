import Foundation
import Testing
@testable import MuesliNativeApp

@Suite("iPhone sync errors")
struct MuesliCKSyncErrorTests {
    @Test("Every error provides actionable copy instead of the Swift enum fallback")
    func localizedDescriptionsAreActionable() {
        let errors: [MuesliCKSyncError] = [
            .iCloudUnavailable,
            .networkUnavailable,
            .syncFailed(message: nil),
        ]

        for error in errors {
            let description = error.localizedDescription
            #expect(description.contains("MuesliCKSyncError") == false)
            #expect(description.contains("try") || description.contains("Try"))
        }
    }

    @Test("Underlying sync details are preserved")
    func underlyingDetailsArePreserved() {
        let error = MuesliCKSyncError.syncFailed(message: "  Your iCloud storage is full.  ")

        #expect(error.localizedDescription == "Muesli couldn’t sync with your iPhone. Your iCloud storage is full.")
    }

    @Test("Blank underlying details use the friendly fallback")
    func blankDetailsUseFallback() {
        let error = MuesliCKSyncError.syncFailed(message: " \n ")

        #expect(error.localizedDescription == "Muesli couldn’t sync with your iPhone. Try again in a moment.")
    }
}
