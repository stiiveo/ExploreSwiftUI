import UIKit

final class AssetImageLoader: ImageLoader {
    private let delayRange: ClosedRange<TimeInterval>
    
    init(delayRange: ClosedRange<TimeInterval>) {
        self.delayRange = delayRange
    }
    
    func load(url: URL) async throws -> Data {
        let delay = Double.random(in: delayRange)
        try await Task.sleep(for: .seconds(delay))
        
        guard let urlDomain = url.host(percentEncoded: false) else {
            return Data()
        }
        
        let imageName = urlDomain
            .replacingOccurrences(of: "www.", with: "", options: .regularExpression)
            .replacingOccurrences(of: ".com", with: "", options: .regularExpression)
        
        return UIImage(named: imageName)?.pngData() ?? Data()
    }
}
