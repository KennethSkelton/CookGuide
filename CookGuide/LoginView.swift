//
//  LoginView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/23/21.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
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
                NavigationLink(destination: Home(username: username)){
                    Button(
                        action: {
                        print("Login button press")
                        //app = login(username: username, password: password)
                        print("Login button end")
                        
                        },
                        label: {
                        }
                    )
                    Text("Login")
                    
                }
                NavigationLink(destination: Home()){
                    Button(
                        action: {
                        print("Signup button press")
                        //signup(username: username, password: password)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
