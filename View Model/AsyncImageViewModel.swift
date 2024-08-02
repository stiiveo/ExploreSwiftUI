import SwiftUI

@MainActor
class AsyncImageViewModel: ObservableObject {
    let url: URL
    let loader: (URL) async throws -> Data
    let mapper: (Data) throws -> Image
    
    @Published private(set) var state: State?
    
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
                state = .loading
                let imageData = try await loader(url)
                let image = try mapper(imageData)
                state = .loaded(image)
            } catch {
                state = .failure(error)
            }
        }
    }
    
    enum State {
        case loaded(Image)
        case loading
        case failure(Error)
    }
}
