
import Foundation

final class StubCompaniesLoader: CompaniesLoader {
    private let stub: [Company]
    private let delay: TimeInterval?
    
    init(stub: [Company], delay: TimeInterval?) {
        self.stub = stub
        self.delay = delay
    }
    
    func load() async throws -> [Company] {
        try await Task.sleep(for: .seconds(delay ?? .zero))
        return stub
    }
}
