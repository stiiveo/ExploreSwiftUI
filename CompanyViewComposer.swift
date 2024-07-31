
import SwiftUI

final class CompanyViewComposer {
    private init() {}
    
    static func composedView() -> some View {
        let viewModel = CompanyListViewModel(
            companiesLoader: MockCompaniesLoader(),
            imageLoader: LocalImageLoader())
        return CompanyView(viewModel: viewModel, cellView: { company in
            let imageViewModel = AsyncImageViewModel(
                url: company.url,
                loader: LocalImageLoader().load,
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
