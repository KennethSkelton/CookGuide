//
//  ContentView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/8/21.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State var existingRecipes = createTestData()
    
    
    
    var body: some View {
        
        VStack{
            HStack{
                
            Text("My Recipes")
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(
                    action: {},
                    label: {
                        Text("+").font(.system(size:60))
                    }
                )
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 50, height: 50)
                    .border(Color.black)
                    
                

            
            }
            Spacer()
            List(){
                ForEach(0..<existingRecipes.count, id: \.self){
                    idx in Button(
                        action: {
                            
                        },
                        label:{
                            HStack{
                                Image(/*@START_MENU_TOKEN@*/"Image Name"/*@END_MENU_TOKEN@*/)
                                Text(existingRecipes[idx])
                                
                            }
                        }
                    )
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
