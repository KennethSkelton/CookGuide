//
//  ContentView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/8/21.
//

import SwiftUI
import RealmSwift


struct HomeView: View {
    
    @State var username = "Kenny@skeltons.com"
    @State var password = "Kennys"
    @State var isNotLoggedin = state.isLoggedIn()
    @State var recipes = localdb.recipes
    @State var linkIsActive = false
    
    
    @State var tempIngredients = [IngredientObject]()
    @State var tempInstructions = [InstructionObject]()
    
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
                        if(recipes.count == 0){
                            Text("You have no recipes")
                        }
                        ForEach(0..<recipes.count, id: \.self){
                            idx in
                            NavigationLink(destination: RecipeInformationView(recipe: recipes[idx], ingredients: tempIngredients, instructions: tempInstructions, instructionTimerStrings: tempInstructions.map { String($0.timerDuration) }), isActive: $linkIsActive){
                                Button(
                                    action: {
                                        
                                        for i in 0..<localdb.ingredients.count{
                                            if(localdb.ingredients[i].recipeID == recipes[i].recipeID){
                                                tempIngredients.append(localdb.ingredients[i])
                                            }
                                        }
                                        
                                        for i in 0..<localdb.instructions.count{
                                            if(localdb.instructions[i].recipeID == recipes[i].recipeID){
                                                tempInstructions.append(localdb.instructions[i])
                                            }
                                        }
                                        
                                        linkIsActive = true
                                    },
                                    label: {
                                        Text(recipes[idx].recipeName)
                                            .font(.system(size:20, weight: .light))
                                    }
                                )
                            }
                        }
                        
                    }
                    .background(primaryColor).ignoresSafeArea()
                    .listStyle(.plain)
                }
                .background(primaryColor).ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
                
                
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink(destination: ScheduleView()){
                            ZStack{
                                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(secondaryColor)
                                Image(systemName: "calendar")
                                    
                            }.padding(30)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 50, height: 50)
                        .padding(30)
                        
                        Spacer()
                        NavigationLink(destination: AddRecipeView()){
                            ZStack{
                                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(secondaryColor)
                                Text("+").foregroundColor(secondaryTextColor).font(.system(size: 30))
                            }.padding(30)
                        }
                        .frame(width: 50, height: 50)
                        .padding(30)
                    }
                }
            }
        }
        .popover(isPresented: $isNotLoggedin){
                VStack{
                    Spacer()
                    Text("Welcome to CookGuide")
                        .font(.system(size: 30))
                    Text("Login")
                        .font(.system(size: 30))
                    TextField(
                        " UserName",
                        text: $username
                    )
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(10)
                    
                    TextField(
                        " Password",
                        text: $password
                    )
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(10)
                    
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
