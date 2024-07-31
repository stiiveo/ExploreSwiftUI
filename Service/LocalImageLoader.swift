import UIKit

final class LocalImageLoader: ImageLoader {
    func load(url: URL) async throws -> Data {
        // simulate delay
        let randomDelay = Double.random(in: 0.1...1.0)
        try await Task.sleep(for: .seconds(randomDelay))
        
        guard let urlDomain = url.host(percentEncoded: false) else {
            return Data()
        }
        
        let imageName = urlDomain
            .replacingOccurrences(of: "www.", with: "", options: .regularExpression)
            .replacingOccurrences(of: ".com", with: "", options: .regularExpression)
        
        return UIImage(named: imageName)?.pngData() ?? Data()
    }
}
