
import SwiftUI

struct LoadingView: View {
    let message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        progressView
            .padding(.all, 24)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var progressView: some View {
        if let message, !message.isEmpty {
            ProgressView(message)
        } else {
            ProgressView()
        }
    }
}
