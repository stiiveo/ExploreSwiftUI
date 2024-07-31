import Foundation

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
