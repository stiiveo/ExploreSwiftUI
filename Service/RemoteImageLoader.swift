import Foundation

struct RemoteImageLoader: ImageLoader {
    func load(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
