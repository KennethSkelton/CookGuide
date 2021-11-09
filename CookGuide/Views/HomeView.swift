//
//  ContentView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/8/21.
//

import SwiftUI
import RealmSwift


struct HomeView: View {
    
    @State var username = ""
    @State var password = ""
    @State var isNotLoggedin = !state.isLoggedIn()
    @State var recipes = localdb.recipes
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("My Recipes")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                            NavigationLink(destination: AddRecipeView()){
                                Text("+").font(.system(size:60))
                                    .frame(width: 50, height: 50)
                                    .border(Color.black)
                                    
                            }
                }
                Spacer()
                List(){
                    ForEach(0..<recipes.count, id: \.self){
                        idx in
                        NavigationLink(destination: RecipeInformationView(recipe: recipes[idx])){
                                Text(recipes[idx].recipeName)
                            }
                    }
                }.border(primaryColor)
            }.background(primaryColor)
        }
        .popover(isPresented: $isNotLoggedin){
                VStack{
                    Spacer()
                    Text("Login or Register")
                    TextField(
                        "UserName",
                        text: $username
                    )
                    
                    TextField(
                        "Password",
                        text: $password
                    )
                    Button(
                        action: {
                            print("Login button press")
                            
                            //Login
                            login(username: username, password: password)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                                print("Login button end")
                                isNotLoggedin = !state.isLoggedIn()
                                initilizeDatabase()
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                recipes = localdb.recipes
                                print("Recipes", recipes)
                                }
                            }
                            
                            
                        },
                        label: {
                            Text("Login")
                        }
                    )
                
                    Button(
                        action: {
                            print("Signup button press")
                            //signup
                            signup(username: username, password: password)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                                print("Signup button end")
                                isNotLoggedin = !state.isLoggedIn()
                                initilizeDatabase()
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                recipes = localdb.recipes
                                print("Recipes", recipes)
                                }
                            }
                        },
                        label: {
                            Text("Register")
                        }
                    )
                    Spacer()
                }.background(primaryColor)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
