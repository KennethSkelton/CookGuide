//
//  AddIngrediantView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import SwiftUI
import RealmSwift


struct AddIngredientView: View {
    
    @State var existingIngredients = [IngredientObject]()
    @State var tempIngredient = ""
    @State var isLinkActive = false
    var recipe = RecipeObject()
    
    var body: some View {
            VStack{
                Text(recipe.recipeName)
                Text("Please enter the ingredients of your recipe")
                List(){
                    ForEach(0..<existingIngredients.count, id: \.self){
                        idx in
                        HStack{
                            Spacer()
                            Text(existingIngredients[idx].ingredient)
                            Spacer()
                            Button(
                                action: {
                                    existingIngredients.remove(at: idx)
                                },
                                
                                label:{
                                    Text("Remove").opacity(0.5).accentColor(.gray)
                                }
                            )
                            Spacer()
                        }
                    }
                }
                HStack{
                    Text("Ingredient: ")
                    
                    TextField(
                        "Ingredient",
                        text: $tempIngredient,
                        onCommit: {
                            existingIngredients.append(IngredientObject(ingredient: tempIngredient, recipeID: recipe.recipeID))
                            tempIngredient = ""
                        })
                    
                }
                NavigationLink(destination: AddInstructionView(recipe: recipe)){
                    Button(
                        action: {
                            saveRealmArray(existingIngredients)
                            for ingredient in existingIngredients {
                                localdb.ingredients.append(ingredient)
                            }
                        },
                        label: {
                            Text("Save")
                        }
                    )
                    Text("Continue")
                }
            }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
