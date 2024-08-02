import SwiftUI

struct CompanyView<Cell: View, LoadingView: View>: View {
    
    @ObservedObject var viewModel: CompanyListViewModel
    let cellView: (Company) -> Cell
    let loadingView: () -> LoadingView
    
    @State private var selectedCompany: Company?
    
    var body: some View {
        ZStack {
            CompanyListView(
                companies: viewModel.companies,
                cellView: { company in
                    cellView(company)
                        .onTapGesture { selectedCompany = company }
                        .disabled(isInteractionDisabled)
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
    
    private var isInteractionDisabled: Bool {
        viewModel.isLoadingCompanies
    }
}
