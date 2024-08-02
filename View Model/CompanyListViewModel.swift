
import SwiftUI

@MainActor
final class CompanyListViewModel: ObservableObject {
    
    @Published private(set) var isLoadingCompanies = false
    @Published private(set) var companies = [Company]()
    
    let companiesLoader: CompaniesLoader
    
    init(companiesLoader: CompaniesLoader) {
        self.companiesLoader = companiesLoader
    }
    
    func loadCompanies() {
        Task {
            do {
                isLoadingCompanies = true
                companies = try await self.companiesLoader.load()
                isLoadingCompanies = false
            } catch {
                print("Failed to load companies with error \(error)")
            }
        }
    }
}
