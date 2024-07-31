import SwiftUI

struct CompanyCellView: View {
    let image: Image
    let title: String
    
    var body: some View {
        Label(
            title: {
                Text(title)
                    .lineLimit(1)
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .minimumScaleFactor(0.1)
            },
            icon: {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.accentColor)
            }
        )
        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(white: 0, opacity: 0.15), radius: 3, x: 0, y: 2)
    }
}
