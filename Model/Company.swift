
import SwiftUI

typealias CompanyID = String

struct Company: Identifiable, Equatable {
    let id: CompanyID
    let name: String
    let iconURL: URL
    let url: URL
}
