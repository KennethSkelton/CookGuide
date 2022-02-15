//
//  CartView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 2/3/22.
//
import SwiftUI
import WebKit
import SwiftSoup







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
    
    
    @State var recipe = RecipeObject()
    
    var body: some View {
        VStack{
            WebView(url: URL(string: createUrl()))
        }
        
    }
    
    private func createUrl() -> String{
        var outputUrl = "http://www.amazon.com/gp/aws/cart/add.html?AssociateTag=your-tag"
        var asinArray = [String()]
        
        
        for ingredient in localdb.ingredients {
            
            
            if(ingredient.recipeID == recipe.recipeID){
                
                var urlString = "https://www.amazon.com/s?k=" + ingredient.ingredient
                
                let url = URL(string: urlString)
                do {
                    let html = try String(contentsOf: url!)
                    let doc: Document = try SwiftSoup.parse(html)
          
                    
                    let element = try doc.getElementsByClass("s-main-slot s-result-list s-search-results sg-row")
                    
                    var elementText = try doc.getElementsByClass("s-main-slot s-result-list s-search-results sg-row").outerHtml()
                
                    print("elementText")
                    print(elementText)
                    
                    var asin = "nil"
                    
                    while(elementText.contains("data-asin")){
                        var range = elementText.range(of:"data-asin")

                        
                        print(elementText[elementText.index(range?.upperBound ?? elementText.startIndex, offsetBy: 1)])
                        
                        
                        print(elementText[elementText.index(range?.upperBound ?? elementText.startIndex, offsetBy: 2)])
                        
                        if(elementText[elementText.index(range?.upperBound ?? elementText.startIndex, offsetBy: 1)] == "\"" && elementText[elementText.index(range?.upperBound ?? elementText.startIndex, offsetBy: 2)] == "\""
                        
                        
                        
                        ){
                            elementText = String(elementText[(range?.upperBound ?? elementText.startIndex)...])
                            
                        }
                        else{
                            var startIndex = elementText.index(range?.upperBound ?? html.startIndex, offsetBy: 2)
                            var endIndex = elementText.index(range?.upperBound ?? html.startIndex, offsetBy: 12)
                            
                            
                            asin = String(elementText[startIndex..<endIndex])
                            asinArray.append(asin)
                            break
                        }
                    
                    }
                    
                    var counter = 1
                    
                    for asin in asinArray{
                        outputUrl += "&ASIN." + String(counter) + "=" + asin + "&" + "Quantity."+String(counter)+"=1"
                        
                        counter+=1
                    }
                    
                }
                catch{
                    print("Failure")
                }
                
            }
        }
        
        
        
        return outputUrl
    }
}

    

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
