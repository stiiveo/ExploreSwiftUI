
import SwiftUI

final class CompanyViewComposer {
    private init() {}
    
    static func composedView() -> some View {
        let companiesLoader = StubCompaniesLoader(stub: mockCompanies, delay: 3)
        let viewModel = CompanyListViewModel(companiesLoader: companiesLoader)
        let imageLoader = AssetImageLoader(delayRange: 0.1...0.5)
        
        return CompanyView(
            viewModel: viewModel,
            cellView: { company in
                let imageViewModel = AsyncImageViewModel(
                    url: company.url,
                    loader: imageLoader.load,
                    mapper: LocalImageMapper.map
                )
                
                return CompanyCellView(
                    viewModel: CompanyCellViewModel(
                        title: company.name,
                        image: AsyncImageView(viewModel: imageViewModel))
                ).onAppear(perform: imageViewModel.load)
            },
            loadingView: { LoadingView(message: "Loading...") })
    }
}

struct LoadingView: View {
    let message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        progressView
            .padding(.all, 24)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var progressView: some View {
        if let message, !message.isEmpty {
            ProgressView(message)
        } else {
            ProgressView()
        }
    }
}
