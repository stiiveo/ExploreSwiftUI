import SwiftUI

struct CompanyView<Cell: View, LoadingView: View>: View {
    
    @ObservedObject var viewModel: CompanyListViewModel
    let cellView: (CompanyViewModel) -> Cell
    let loadingView: () -> LoadingView
    
    @State private var selectedCompany: CompanyViewModel?
    
    var body: some View {
        ZStack {
            CompanyListView(
                companies: viewModel.companies,
                cellView: { company in
                    cellView(company)
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
            
            if viewModel.isLoadingCompanies { loadingView() }
        }
        .task {
            viewModel.loadCompanies()
        }
    }
}
