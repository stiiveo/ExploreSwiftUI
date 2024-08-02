
import SwiftUI

final class CompanyListViewModel: ObservableObject {
    
    @Published private(set) var isLoadingCompanies = false
    @Published private(set)var companies = [Company]()
    
    let companiesLoader: CompaniesLoader
    
    init(companiesLoader: CompaniesLoader) {
        self.companiesLoader = companiesLoader
    }
    
    func loadCompanies() {
        Task {
            do {
                await MainActor.run { [weak self] in
                    self?.isLoadingCompanies = true
                }
                
                let companies = try await self.companiesLoader.load()
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    self.companies = companies
                    self.isLoadingCompanies = false
                }
            } catch {
                print("Failed to load companies with error \(error)")
            }
        }
    }
}
