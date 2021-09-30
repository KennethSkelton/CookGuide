//
//  AddInstructionView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import SwiftUI

struct AddInstructionView: View {
    
    var ingredients = [IngredientObject]()
    
    @State var existingInstructions = [InstructionObject]()
    @State var tempInstruction = ""
    @State var textTempTimer = "";
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Please enter the instructions of your recipe")
                List(){
                    ForEach(0..<existingInstructions.count, id: \.self){
                        idx in
                        HStack{
                            Spacer()
                            Text(existingInstructions[idx].instruction)
                            Spacer()
                            Button(
                                action: {
                                    existingInstructions.remove(at: idx)
                                },
                                
                                label:{
                                    Text("Remove").opacity(0.5).accentColor(.gray)
                                }
                            )
                            Spacer()
                        }
                    }
                }
            VStack{
                HStack{
                    Text("Instruction: ")
                    TextField(
                        "Intruction",
                        text: $tempInstruction
                       )
                    Spacer()
                    Text("Timer: ")
                    TextField(
                        "Time",
                        text: $textTempTimer
                       )
                }
                Button(
                    action: {
                        let intTimer: Int? = Int(textTempTimer)
                        if(intTimer ?? 0 > 0){
                            existingInstructions.append(InstructionObject(instruction: tempInstruction, hasTimer: true, timerDuration: intTimer ?? 0))
                        }
                        else{
                            existingInstructions.append(InstructionObject(instruction: tempInstruction, hasTimer: false, timerDuration: 0))
                        }
                        textTempTimer = "";
                        tempInstruction = "";
                    },
                    label: {
                        Text("Submit Instruction")
                    }
                )
            }
                NavigationLink(destination: Home()){
                    Button(
                        action: {
                            
                            //Database here
                            localdb.recipies.append(RecipeObject(recipeName: "temp", ingredients: ingredients, instructions: existingInstructions))
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

struct AddInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        AddInstructionView()
    }
}