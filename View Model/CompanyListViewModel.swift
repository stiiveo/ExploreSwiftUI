
import SwiftUI

final class CompanyListViewModel: ObservableObject {
    
    @Published var isLoadingCompanies = false
    @Published var companies = [CompanyViewModel]()
    
    let companiesLoader: CompaniesLoader
    let imageLoader: ImageLoader
    
    init(
        companiesLoader: CompaniesLoader,
        imageLoader: ImageLoader
    ) {
        self.companiesLoader = companiesLoader
        self.imageLoader = imageLoader
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
                    
                    self.companies = companies.map { CompanyViewModelMapper.map($0) }
                    self.isLoadingCompanies = false
                }
            } catch {
                print("Failed to load companies with error \(error)")
            }
        }
    }
    
    private func index(for companyID: CompanyID, in companies: [CompanyViewModel]) -> Int? {
        return companies.firstIndex(where: { $0.id == companyID })
    }
}

let buildingImage = UIImage(systemName: "building")!
