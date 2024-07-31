import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            CompanyViewComposer.composedView()
        }
    }
}

final class CompanyViewComposer {
    private init() {}
    
    static func composedView() -> some View {
        let viewModel = CompanyListViewModel(
            companiesLoader: MockCompaniesLoader(),
            imageLoader: LocalImageLoader())
        return CompanyView(viewModel: viewModel)
    }
}
