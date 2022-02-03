//
//  RecipeInformationView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/30/21.
//

import SwiftUI

struct RecipeInformationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var recipe = RecipeObject()
    @State var ingredients = [IngredientObject]()
    @State var instructions = [InstructionObject]()

    @State var instructionTimerStrings = [String]()
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text(recipe.recipeName)
            }
            Spacer()
            Text("Ingredients")
            List(){
                ForEach(0..<ingredients.count, id: \.self){
                    idx in
                    TextEditor(text: $ingredients[idx].ingredient)
                }
            }
            Spacer()
            Text("Instructions")
            List(){
                ForEach(0..<instructions.count, id: \.self){
                    idx in
                    HStack{
                        TextEditor(text: $instructions[idx].instruction)
                        TextEditor(text: $instructionTimerStrings[idx])
                    }
                }
                
            }
            Button(
                action: {
                updateLocalDatabaseRecipe(object: recipe)
                updateLocalDatabaseIngredientArray(objects: ingredients)
                updateLocalDatabaseInstructionArray(objects: instructions)
                    
                updateRealmObject(recipe)
                updateRealmArray(ingredients)
                updateRealmArray(instructions)
                    
                self.presentationMode.wrappedValue.dismiss()
                
            },
                label: {
                    Text("Save")
            })
        }
        .background(primaryColor).ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear(perform: fillData)
    }
    private func fillData() {
        
        for element in localdb.ingredients {
            if(element.recipeID == recipe.recipeID){
                ingredients.append(element)
            }
        }
        
        for element in localdb.instructions {
            if(element.recipeID == recipe.recipeID){
                instructions.append(element)
                instructionTimerStrings.append(String(element.timerDuration))
            }
            
        }
    }
}

struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView()
    }
}
