import SwiftUI

struct CompanyView: View {
    
    @ObservedObject var viewModel: CompanyListViewModel
    let imageMapper: (Data) -> Image
    
    @State private var selectedCompany: CompanyViewModel?
    
    var body: some View {
        ZStack {
            CompanyListView(
                companies: $viewModel.companies.wrappedValue,
                cellView: { company in
                    return CompanyCellView(
                        image: imageMapper(company.image),
                        title: company.name
                    )
                    .onAppear { viewModel.loadImage(for: company) }
                    .onTapGesture { selectedCompany = company }
                },
                onRefresh: viewModel.loadCompanies
            )
            .sheet(item: $selectedCompany) { company in
                NavigationWrappedWebView(
                    url: company.url,
                    title: company.name,
                    onTapClose: { selectedCompany = nil })
            }
            
            if viewModel.isLoadingCompanies {
                ProgressView("Loading Companies")
            }
        }
        .task {
            viewModel.loadCompanies()
        }
    }
}
