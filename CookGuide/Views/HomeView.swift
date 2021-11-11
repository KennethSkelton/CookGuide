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
            ZStack{
                VStack{
                    HStack{
                        Text("My Recipes")
                            .frame(height: 100, alignment: .center)
                            .background(primaryColor)
                            .font(.system(size:30, weight: .light, design: .serif))
                            
                    }
                    Spacer()
                    List(){
                        ForEach(0..<recipes.count, id: \.self){
                            idx in
                            NavigationLink(destination: RecipeInformationView(recipe: recipes[idx])){
                                Text(recipes[idx].recipeName)
                                    .font(.system(size:20, weight: .light))
                                    
                            }.background(secondaryColor)
                        }
                    }.background(primaryColor).ignoresSafeArea()
                }
                .background(primaryColor).ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
                
                NavigationLink(destination: AddRecipeView()){
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            ZStack{
                                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(secondaryColor)
                                Text("+").foregroundColor(secondaryTextColor).font(.system(size: 30))
                            }.padding(30)
                                
                        }
                    }
                }.frame(alignment: .bottomTrailing)
                
            }
        }
        .popover(isPresented: $isNotLoggedin){
                VStack{
                    Spacer()
                    Spacer()
                    Text("Login")
                        .font(.system(size: 30))
                    Spacer()
                    TextField(
                        " UserName",
                        text: $username
                    )
                        .overlay(
                        Capsule()
                            .stroke(lineWidth: 1)
                            .opacity(0.7)
                        )
                        .padding()
                    
                    TextField(
                        " Password",
                        text: $password
                    )
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(5)
                    
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
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 80, height: 30)
                                    .foregroundColor(secondaryColor)
                            Text("Login")
                                .foregroundColor(secondaryTextColor)
                            }
                            
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
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 80, height: 30)
                                    .foregroundColor(secondaryColor)
                            Text("Register")
                                .foregroundColor(secondaryTextColor)
                            }
                        }
                    )
                    Spacer()
                }.background(primaryColor).ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
