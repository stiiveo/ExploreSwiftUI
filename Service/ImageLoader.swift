import SwiftUI

protocol ImageLoader {
    func load(url: URL) async throws -> Data
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
