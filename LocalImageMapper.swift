import SwiftUI

struct LocalImageMapper {
    static func map(_ data: Data) throws -> Image {
        if let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            throw UnmappableData(data, targetType: Image.self)
        }
    }
}

struct UnmappableData<T>: LocalizedError {
    let data: Data
    let targetType: T.Type
    
    init(_ data: Data, targetType: T.Type) {
        self.data = data
        self.targetType = targetType
    }
    
    var errorDescription: String? {
        "Unable to map data \(data) to \(targetType)"
    }
}
