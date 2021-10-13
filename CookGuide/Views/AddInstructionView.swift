//
//  AddInstructionView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import SwiftUI

struct AddInstructionView: View {
    
    @State var existingInstructions = [InstructionObject]()
    @State var tempInstruction = ""
    @State var textTempTimer = "";
    @State var recipe = RecipeObject()
    
    var body: some View {
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
                            existingInstructions.append(InstructionObject(instruction: tempInstruction, hasTimer: true, timerDuration: intTimer ?? 0, recipeID: recipe.recipeID))
                        }
                        else{
                            existingInstructions.append(InstructionObject(instruction: tempInstruction, hasTimer: false, timerDuration: 0, recipeID: recipe.recipeID))
                        }
                        textTempTimer = "";
                        tempInstruction = "";
                    },
                    label: {
                        Text("Submit Instruction")
                    }
                )
            }
                NavigationLink(destination: HomeView()){
                    Button(
                        action: {
                            
                            //Database here
                            var i:Int = 1
                            for instruction in existingInstructions {
                                instruction.order = i;
                                i+=1;
                                localdb.instructions.append(instruction)
                            }
                            
                            localdb.recipies.append(recipe)
                            saveRealmObject(recipe)
                            saveRealmArray(existingInstructions)
                            
                        },
                        label: {
                            Text("save")
                        }
                    )
                    
                    Text("continue")
                }
            }
    }
}

struct AddInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        AddInstructionView()
    }
}
