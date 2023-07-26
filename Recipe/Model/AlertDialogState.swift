import Foundation
import SwiftUI

struct AlertDialogState: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var primaryButton: Alert.Button
    var secondaryButton: Alert.Button?
}
