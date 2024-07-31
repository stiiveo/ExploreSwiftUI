import SwiftUI

class AsyncImageViewModel: ObservableObject {
    let url: URL
    let loader: (URL) async throws -> Data
    let mapper: (Data) throws -> Image
    
    @Published var state: State?
    
    init(
        url: URL,
        loader: @escaping (URL) async throws -> Data,
        mapper: @escaping (Data) throws -> Image
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
                let image = try mapper(imageData)
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
