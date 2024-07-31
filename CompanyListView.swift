import SwiftUI

struct CompanyListView: View {
    let companies: [CompanyViewModel]
    let onTapCompany: (CompanyViewModel) -> Void
    let onAppearCompany: (CompanyViewModel) -> Void
    let onRefresh: () -> Void
    
    private let maxCellWidth = CGFloat(180)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(
                    columns: generateColumns(
                        viewWidth: geometry.size.width,
                        maxColumnWidth: maxCellWidth
                    ),
                    alignment: .leading,
                    spacing: 12
                ) {
                    makeCompaniesView(companies: companies)
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }.refreshable { onRefresh() }
        }
        .animation(.default, value: companies)
    }
    
    private func generateColumns(viewWidth: CGFloat, maxColumnWidth: CGFloat) -> [GridItem] {
        let numberOfColumns = max(1, Int(viewWidth) / Int(maxColumnWidth))
        return Array(repeating: GridItem(.flexible(), spacing: 12), count: numberOfColumns)
    }
    
    @ViewBuilder
    private func makeCompaniesView(companies: [CompanyViewModel]) -> some View {
        ForEach(companies) { company in
            CompanyCellView(
                image: Image(uiImage: UIImage(data: company.image)!),
                title: company.name
            )
            .onAppear { onAppearCompany(company) }
            .onTapGesture { onTapCompany(company) }
        }
    }
}
