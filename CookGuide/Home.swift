//
//  ContentView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/8/21.
//

import SwiftUI
import RealmSwift


struct Home: View {
    
    
    
    @State var existingRecipes = createTestData()
    var username = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello " + username)
                
                HStack{
                    Text("My Recipes")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                            NavigationLink(destination: AddIngredientView()){
                                Text("+").font(.system(size:60))
                                    .frame(width: 50, height: 50)
                                    .border(Color.black)
                            }
                }
                Spacer()
                List(){
                    ForEach(0..<existingRecipes.count, id: \.self){
                        idx in Button(
                            action: {
                                
                            },
                            label:{
                                HStack{
                                    Text(localdb.recipies[idx].recipeName)
                                    
                                }
                            }
                        )
                    }
                }
                Spacer()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
