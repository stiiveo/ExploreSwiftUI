import SwiftUI

struct CompanyListView<CellView>: View where CellView: View {
    let companies: [CompanyViewModel]
    let cellView: (CompanyViewModel) -> CellView
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
                    ForEach(companies) { company in
                        cellView(company)
                    }
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
}
