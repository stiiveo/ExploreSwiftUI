
import SwiftUI

struct NavigationWrappedWebView: View {
    let url: URL?
    let title: String
    let onTapClose: () -> Void
    
    var body: some View {
        NavigationStack {
            Group {
                if let url {
                    WebView(url: url)
                } else {
                    Text("No URL Provided")
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        role: .cancel,
                        action: onTapClose,
                        label: { Image.toolbarCloseButton() })
                }
            }
        }
    }
}

extension Image {
    static func toolbarCloseButton() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .scaledToFit()
            .frame(width: 12, height: 12)
            .padding(7.5)
            .fontWeight(.bold)
            .background(.gray.opacity(0.2), in: Circle())
    }
}

#Preview {
    NavigationWrappedWebView(url: URL.google,
                             title: "Google",
                             onTapClose: { print("close") })
}

