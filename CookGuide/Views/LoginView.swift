//
//  LoginView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/23/21.
//

/*Depreciated, not needed anymore*/


import SwiftUI
import RealmSwift

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
        VStack{
        
            NavigationView {
                VStack{
                    TextField(
                        "UserName",
                        text: $username
                    )
                    
                    TextField(
                        "Password",
                        text: $password
                    )
                    NavigationLink(destination: HomeView(username: username)){
                        Button(
                            action: {
                            print("Login button press")
                            //Login
                            login(username: username, password: password)
                            print("Login button end")
                            
                            },
                            label: {
                                Text("Login")
                            }
                        )
                        Text("Login")
                        
                        
                    }
                    NavigationLink(destination: HomeView(username: username)){
                        Button(
                            action: {
                            print("Signup button press")
                            //signup
                            signup(username: username, password: password)
                            print("Signup button end")
                            
                            },
                            label: {
                            }
                        )
                        Text("Register")
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
