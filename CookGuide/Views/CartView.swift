//
//  CartView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 2/3/22.
//
import WebKit
import SwiftUI


struct WebView: UIViewRepresentable{
    let url: URL?
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url = url else {
            return
        }
        
        webView.load(.init(url: url))
    }
    
}






struct CartView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.amazon.com/gp/cart/view.html?ref_=nav_cart"))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
