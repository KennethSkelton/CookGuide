//
//  AddIngrediantView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import SwiftUI





struct AddIngredientView: View {
    
    @State var existingIngredients = [String]()
    @State var tempIngredient = ""
    
    var body: some View {
        VStack{
            Text("Please enter the ingredients of your recipe")
            List(){
                ForEach(0..<existingIngredients.count, id: \.self){
                    idx in Text(existingIngredients[idx])
                }
            }
            HStack{
                Text("Ingredient: ")
                
                TextField(
                    "Ingredient",
                    text: $tempIngredient,
                    onCommit: {
                        existingIngredients.append(tempIngredient)
                        tempIngredient = ""
                    })
                Text(tempIngredient)
                
            }
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
