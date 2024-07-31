import SwiftUI

protocol ImageLoader {
    func load(url: URL) async throws -> Data?
}

final class InMemoryImageCache {
    
    private var cache = [URL: Data]()
    
    private let queue = DispatchQueue(label: "com.exploreswiftui.inMemoryImageCache.queue", attributes: .concurrent)
    
    func insert(_ image: Data, url: URL) {
        guard cache[url] == nil else { return }
        
        queue.async(flags: .barrier) { [weak self] in
            self?.cache[url] = image
        }
    }
    
    func retrieve(url: URL) -> Data? {
        cache[url]
    }
}

final class LocalImageLoader: ImageLoader {
    func load(url: URL) async throws -> Data? {
        // simulate delay
        let randomDelay = Double.random(in: 0.1...1.0)
        try await Task.sleep(for: .seconds(randomDelay))
        
        guard let urlDomain = url.host(percentEncoded: false) else {
            return nil
        }
        
        let imageName = urlDomain
            .replacingOccurrences(of: "www.", with: "", options: .regularExpression)
            .replacingOccurrences(of: ".com", with: "", options: .regularExpression)
        
        return UIImage(named: imageName)?.pngData()
    }
}

struct RemoteImageLoader: ImageLoader {
    func load(url: URL) async throws -> Data? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

struct LocalImageMapper {
    static func map(_ data: Data) -> Image {
        Image(uiImage: UIImage(data: data) ?? UIImage())
    }
}

struct UnmappableImageData: LocalizedError {
    let data: Data
    
    init(_ data: Data) {
        self.data = data
    }
    
    var errorDescription: String? {
        "Failed to map data \(data) to image"
    }
}
