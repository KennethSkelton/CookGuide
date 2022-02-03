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
    
    @State var parsedIngredientObjects = [IngredientObject]()
    @State var parsedInstructionObjects = [InstructionObject]()
    
    @State var linkIsActive = false
    
    
    var body: some View {
        VStack{
            Spacer()
            TextField("https://www.allrecipes.com/recipe/ ...", text: $urlString)
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
                            parsedIngredients.append(try fractionReplacer(input: ingredients[i].text()))
                            
                            parsedIngredientObjects.append(IngredientObject(ingredient: parsedIngredients[i], recipeID: recipe.recipeID))
                            
                            localdb.ingredients.append(IngredientObject(ingredient: parsedIngredients[i], recipeID: recipe.recipeID))
                            
                        }
                        
                        let instructions = try doc.getElementsByClass("subcontainer instructions-section-item")
                        for i in 0..<instructions.count{
                            parsedInstructions.append(try fractionReplacer(input: instructions[i].text()))
                            
                            parsedInstructionObjects.append(InstructionObject(instruction: parsedInstructions[i], hasTimer: false, timerDuration: 0, order: i, recipeID: recipe.recipeID))
                            
                            localdb.instructions.append(InstructionObject(instruction: parsedInstructions[i], hasTimer: false, timerDuration: 0, order: i, recipeID: recipe.recipeID))
                        }
                        localdb.recipes.append(recipe)
                        
                        print(parsedIngredients)
                        print(parsedInstructions)
                        
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
        }
        .background(primaryColor).ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        Spacer()
        NavigationLink(destination: RecipeInformationView(recipe: recipe), isActive: $linkIsActive){
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
                            parsedIngredients.append(try fractionReplacer(input: ingredients[i].text()))
                            
                            parsedIngredientObjects.append(IngredientObject(ingredient: parsedIngredients[i], recipeID: recipe.recipeID))
                            
                            localdb.ingredients.append(IngredientObject(ingredient: parsedIngredients[i], recipeID: recipe.recipeID))
                            
                        }
                        
                        let instructions = try doc.getElementsByClass("subcontainer instructions-section-item")
                        for i in 0..<instructions.count{
                            parsedInstructions.append(try fractionReplacer(input: instructions[i].text()))
                            
                            parsedInstructionObjects.append(InstructionObject(instruction: parsedInstructions[i], hasTimer: false, timerDuration: 0, order: i, recipeID: recipe.recipeID))
                            
                            localdb.instructions.append(InstructionObject(instruction: parsedInstructions[i], hasTimer: false, timerDuration: 0, order: i, recipeID: recipe.recipeID))
                        }
                        localdb.recipes.append(recipe)
                        
                        print(parsedIngredients)
                        print(parsedInstructions)
                        
                    }
                    catch {
                        print("Failure")
                        
                    }
                    
                    
                    saveRealmArray(parsedIngredientObjects)
                    saveRealmArray(parsedInstructionObjects)
                    saveRealmObject(recipe)
                    linkIsActive = true
            },
                label: {
                    ZStack{
                    RoundedRectangle(cornerRadius: 10)
                            .frame(width: 80, height: 30)
                            .foregroundColor(secondaryColor)
                    Text("Save")
                        .foregroundColor(secondaryTextColor)
                    }
                    .padding(8)
            })
        }
        
    }
}

struct WebParserView_Previews: PreviewProvider {
    static var previews: some View {
        WebParserView()
    }
}
