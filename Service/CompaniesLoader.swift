

protocol CompaniesLoader {
    func load() async throws -> [Company]
}

final class MockCompaniesLoader: CompaniesLoader {
    private var count = 0
    
    func load() async throws -> [Company] {
        try await Task.sleep(for: .seconds(0.5))
        let total = mockCompanies.count
        count += 1
        return mockCompanies.suffix(total - count)
    }
}
