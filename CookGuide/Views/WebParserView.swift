//
//  WebParserView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 11/17/21.
//

import SwiftUI
import WebKit
import SwiftSoup

struct WebParserView: View {
    
    @State var urlString = ""
    @State var recipe = RecipeObject()
    @State var parsedIngredients = [String]()
    @State var parsedInstructions = [String]()
    
    
    var body: some View {
        VStack{
            TextField("URL", text: $urlString)
                .overlay(
                    Capsule()
                        .stroke(lineWidth: 1)
                        .opacity(0.7)
                )
                .padding(10)
            Button(
                action: {
                    
                    let url = URL(string: urlString)
                    do {
                        let html = try String(contentsOf: url!)
                        let doc: Document = try SwiftSoup.parse(html)
              
                        
                        
                        let recipeName = try doc.getElementsByClass("headline heading-content elementFont__display").text()
                        
                        recipe = RecipeObject(recipeName: recipeName, userID: app.currentUser?.id ?? "None")
                        
                        let ingredients = try doc.getElementsByClass("ingredients-item-name")
                        
                        for i in 0..<ingredients.count{
                            parsedIngredients[i] = try ingredients[i].text()
                            
                        }
                        
                        let instructions = try doc.getElementsByClass("subcontainer instructions-section-item")
                        for i in 0..<instructions.count{
                            parsedIngredients[i] = try instructions[i].text()
                        }
                    }
                    catch {
                        print("Failure")
                        
                    }
                },
                label: {
                    ZStack{
                    RoundedRectangle(cornerRadius: 10)
                            .frame(height: 30)
                            .foregroundColor(secondaryColor)
                    Text("Parse Recipe")
                        .foregroundColor(secondaryTextColor)
                    }
                    
                }
            )
            HStack{
                Text(recipe.recipeName)
                NavigationLink(destination: EditRecipeView(recipe: recipe)){
                    Text("Edit")
                }
            }
            Spacer()
            Text("Ingredients")
            List(){
                ForEach(0..<localdb.ingredients.count, id: \.self){
                    idx in
                    if(localdb.ingredients[idx].recipeID == recipe.recipeID){
                        Text(localdb.ingredients[idx].ingredient)
                        
                    }
                }
            }
            Spacer()
            Text("Instructions")
            List(){
                ForEach(0..<localdb.instructions.count, id: \.self){
                    idx in
                    if(localdb.instructions[idx].recipeID == recipe.recipeID){
                        Text(localdb.instructions[idx].instruction)
                        
                    }
                }
                
            }
        }
        .background(primaryColor).ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        Spacer()
        
        
    }
}

struct WebParserView_Previews: PreviewProvider {
    static var previews: some View {
        WebParserView()
    }
}
