import SwiftUI

protocol ImageLoader {
    func load(url: URL) async throws -> Data
}
