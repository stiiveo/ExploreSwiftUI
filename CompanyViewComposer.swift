
import SwiftUI

final class CompanyViewComposer {
    private init() {}
    
    static func composedView() -> some View {
        let viewModel = CompanyListViewModel(
            companiesLoader: StubCompaniesLoader(stub: mockCompanies, delay: 0.3),
            imageLoader: AssetImageLoader(delayRange: 0.1...0.5))
        return CompanyView(viewModel: viewModel, cellView: { company in
            let imageViewModel = AsyncImageViewModel(
                url: company.url,
                loader: AssetImageLoader(delayRange: 0.1...0.5).load,
                mapper: LocalImageMapper.map
            )
            return CompanyCellView(
                viewModel: CompanyCellViewModel(
                    title: company.name,
                    image: AsyncImageView(viewModel: imageViewModel)
                )
            )
            .onAppear(perform: imageViewModel.load)
        })
    }
}
