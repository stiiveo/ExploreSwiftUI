import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let webView = uiView as? WKWebView {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

#Preview {
    WebView(url: URL.google)
}

extension URL {
    static var google: URL {
        URL(string: "https://www.google.com")!
    }
}
