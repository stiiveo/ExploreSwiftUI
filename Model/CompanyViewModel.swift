
import SwiftUI

struct CompanyViewModel: Identifiable, Equatable {
    let id: CompanyID
    let name: String
    let url: URL
    var iconData: Data?
}
