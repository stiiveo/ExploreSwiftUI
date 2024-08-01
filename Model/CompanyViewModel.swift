
import SwiftUI

struct CompanyViewModel: Identifiable, Equatable {
    let id: CompanyID
    let name: String
    var iconData: Data
    let url: URL
}
