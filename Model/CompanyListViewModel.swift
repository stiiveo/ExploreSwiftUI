
import SwiftUI

final class CompanyListViewModel: ObservableObject {
    
    @Published var isLoadingCompanies = false
    @Published var companies = [CompanyViewModel]()
    
    let companiesLoader: CompaniesLoader
    let imageLoader: ImageLoader
    
    private let imageCache = InMemoryImageCache()
    
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
    
//    func loadImage(for company: CompanyViewModel) {
//        if let cache = imageCache.retrieve(url: company.url),
//           let index = index(for: company.id, in: companies) {
//            companies[index].image = cache
//        }
//        
//        Task {
//            do {
//                if let image = try await imageLoader.load(url: company.url),
//                   let index = index(for: company.id, in: companies) {
//                    imageCache.insert(image, url: company.url)
//                    
//                    await MainActor.run { [weak self] in
//                        guard let self else { return }
//                        
//                        self.companies[index].image = image
//                    }
//                }
//            } catch {
//                print("Failed to load icon for company \(company) with error \(error)")
//            }
//        }
//    }
    
    private func index(for companyID: CompanyID, in companies: [CompanyViewModel]) -> Int? {
        return companies.firstIndex(where: { $0.id == companyID })
    }
}

let buildingImage = UIImage(systemName: "building")!

struct CompanyViewModelMapper {
    
    private static var defaultIconData: Data {
        buildingImage.pngData()!
    }
    
    static func map(_ company: Company) -> CompanyViewModel {
        CompanyViewModel(id: company.id, name: company.name, image: defaultIconData, url: company.url)
    }
}
