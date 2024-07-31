
import SwiftUI

struct CompanyViewModel: Identifiable, Equatable {
    let id: CompanyID
    let name: String
    var image: Data
    let url: URL
}
