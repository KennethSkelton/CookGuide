//
//  AddRecipeView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 10/1/21.
//

import SwiftUI



struct AddRecipeView: View {
   
    @State var recipeName = ""
    @State var linkIsActive = false
    @State var recipe = RecipeObject()
    
    
    var body: some View {
            VStack{
                Spacer()
                Text("Name Your Recipe")
                HStack{
                    Spacer()
                    Text("Recipe Name")
                    TextField(" Name",text: $recipeName)
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(5)
                    Spacer()
                }
                NavigationLink(destination: AddIngredientView(recipe: recipe), isActive: $linkIsActive){
                    Button(
                        action: {
                        recipe = RecipeObject(recipeName: recipeName, userID: app.currentUser?.id ?? "None")
                        linkIsActive = true
                        },
                        label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 80, height: 30)
                                    .foregroundColor(secondaryColor)
                            Text("Submit")
                                .foregroundColor(secondaryTextColor)
                            }
                        
                        }
                    )
                }
                Spacer()
                        
            }
            .background(primaryColor).ignoresSafeArea()
                
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
