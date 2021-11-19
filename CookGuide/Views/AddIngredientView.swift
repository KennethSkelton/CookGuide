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
    @State var linkIsActive = false
    var recipe = RecipeObject()
    
    var body: some View {
            VStack{
                Spacer()
                Text(recipe.recipeName)
                    .font(.system(size:30, weight: .light))
                    .padding()
                Text("Please enter the ingredients of your recipe")
                    .font(.system(size:15, weight: .light))
                    .padding()
                List(){
                    ForEach(0..<existingIngredients.count, id: \.self){
                        idx in
                        HStack{
                            Text(existingIngredients[idx].ingredient)
                                .font(.system(size:20, weight: .light))
                                .padding()
                            Spacer()
                            Button(
                                action: {
                                    existingIngredients.remove(at: idx)
                                },
                                
                                label:{
                                    Text("Remove")
                                        .opacity(0.8)
                                        .foregroundColor(.red)
                                }
                            )
                                .padding()
                        }
                    }
                    .background(primaryColor).ignoresSafeArea()
                    .listStyle(.plain)
                }
                HStack{
                    Text("Ingredient: ")
                    TextField(
                        "  Ingredient",
                        text: $tempIngredient,
                        onCommit: {
                            existingIngredients.append(IngredientObject(ingredient: tempIngredient, recipeID: recipe.recipeID))
                            tempIngredient = ""
                        })
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(10)
                    
                }
                .padding()
                NavigationLink(destination: AddInstructionView(recipe: recipe, existingIngredients: existingIngredients), isActive: $linkIsActive){
                    Button(
                        action: {
                            linkIsActive = true
                        },
                        label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 240, height: 30)
                                    .foregroundColor(secondaryColor)
                            Text("Continue to Instructions")
                                .foregroundColor(secondaryTextColor)
                            }
                            .padding()
                        }
                    )
                }
            Spacer()
            }
            .background(primaryColor).ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
