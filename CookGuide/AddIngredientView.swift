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
    
    var body: some View {
        NavigationView {
            VStack{
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
                            //var id = UUID()
                            //temp._id = id.uuidString
                            existingIngredients.append(IngredientObject(ingredient: tempIngredient, recipeID: "1"))
                            tempIngredient = ""
                        })
                    
                }
                NavigationLink(destination: AddInstructionView(ingredients: existingIngredients)){
                    Button(
                        action: {
                        //saveRealmArray(existingIngredients)
                        },
                        label: {
                        }
                    )
                    Text("Submit")
                }
            }
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
