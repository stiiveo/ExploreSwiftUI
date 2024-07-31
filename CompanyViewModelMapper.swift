import Foundation

struct CompanyViewModelMapper {
    
    private static var defaultIconData: Data {
        buildingImage.pngData()!
    }
    
    static func map(_ company: Company) -> CompanyViewModel {
        CompanyViewModel(id: company.id, name: company.name, image: defaultIconData, url: company.url)
    }
}
