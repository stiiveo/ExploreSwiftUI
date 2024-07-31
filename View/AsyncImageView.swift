import SwiftUI

struct AsyncImageView: View {
    @ObservedObject var viewModel: AsyncImageViewModel
    
    var body: some View {
        switch viewModel.state {
        case let .loaded(image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
        case .loading:
            ProgressView()
        case let .failure(error):
            Text(error.localizedDescription)
        case .none:
            Color(.gray).opacity(0.5)
        }
    }
}
