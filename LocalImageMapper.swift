import SwiftUI

struct LocalImageMapper {
    static func map(_ data: Data) -> Image {
        Image(uiImage: UIImage(data: data) ?? UIImage())
    }
}
