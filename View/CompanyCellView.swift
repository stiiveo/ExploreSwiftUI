import SwiftUI

struct CompanyCellView: View {
    let viewModel: CompanyCellViewModel
    
    var body: some View {
        Label(
            title: {
                Text(viewModel.title)
                    .lineLimit(1)
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .minimumScaleFactor(0.1)
            },
            icon: {
                viewModel.image
                    .frame(width: 24, height: 24)
            }
        )
        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(white: 0, opacity: 0.15), radius: 3, x: 0, y: 2)
    }
}

struct CompanyCellViewModel {
    let title: String
    let image: AsyncImageView
}

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
            Color(.gray).opacity(0.5).clipShape(Circle())
        }
    }
}

class AsyncImageViewModel: ObservableObject {
    let url: URL
    let loader: (URL) async throws -> Data
    let mapper: (Data) -> Image
    
    @Published var state: State?
    
    init(
        url: URL,
        loader: @escaping (URL) async throws -> Data,
        mapper: @escaping (Data) -> Image
    ) {
        self.url = url
        self.loader = loader
        self.mapper = mapper
    }
    
    func load() {
        Task {
            do {
                updateState(.loading)
                let imageData = try await loader(url)
                let image = mapper(imageData)
                updateState(.loaded(image))
            } catch {
                updateState(.failure(error))
            }
        }
    }
    
    private func updateState(_ state: State) {
        if Thread.isMainThread {
            self.state = state
        } else {
            DispatchQueue.main.async {
                self.state = state
            }
        }
    }
    
    enum State {
        case loaded(Image)
        case loading
        case failure(Error)
    }
}
