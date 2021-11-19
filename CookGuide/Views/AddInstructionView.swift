//
//  AddInstructionView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import SwiftUI

struct AddInstructionView: View {
    
    @State var recipe = RecipeObject()
    @State var existingInstructions = [InstructionObject]()
    @State var existingIngredients = [IngredientObject]()
    @State var tempInstruction = ""
    @State var textTempTimer = "";
    @State var linkIsActive = false
    
    
    var body: some View {
            VStack{
                Spacer()
                Text("Please enter the instructions of your recipe")
                    .padding()
                List(){
                    ForEach(0..<existingInstructions.count, id: \.self){
                        idx in
                        HStack{
                            
                            Text(existingInstructions[idx].instruction)
                                .font(.system(size:20, weight: .light))
                                .padding(10)
                            Spacer()
                            Button(
                                action: {
                                    existingInstructions.remove(at: idx)
                                },
                                
                                label:{
                                    Text("Remove")
                                        .opacity(0.8)
                                        .foregroundColor(.red)
                                }
                            )
                                .padding(10)
                            
                        }
                    }
                }
            VStack{
                HStack{
                    Text("Instruction: ")
                        .font(.system(size: 15))
                    TextField(
                        " Instruction",
                        text: $tempInstruction
                        )
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .font(.system(size: 15))
                    Spacer()
                    Text("Timer: ")
                        .font(.system(size: 15))
                    TextField(
                        " Time",
                        text: $textTempTimer
                        )
                        .overlay(
                            Capsule()
                                .stroke(lineWidth: 1)
                                .opacity(0.7)
                        )
                        .padding(10)
                        .font(.system(size: 15))
                    
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
                        ZStack{
                        RoundedRectangle(cornerRadius: 10)
                                .frame(width: 240, height: 30)
                                .foregroundColor(secondaryColor)
                        Text("Submit Instruction")
                            .foregroundColor(secondaryTextColor)
                        }
                        .padding(8)
                    }
                )
            }
                NavigationLink(destination: HomeView(), isActive: $linkIsActive){
                    Button(
                        action: {
                            
                            //Database here
                            var i:Int = 1
                            for instruction in existingInstructions {
                                instruction.order = i;
                                i+=1;
                            }
                            linkIsActive = true
                        },
                        label: {
                            ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 240, height: 30)
                                    .foregroundColor(secondaryColor)
                            Text("Complete Recipe")
                                .foregroundColor(secondaryTextColor)
                            }
                            .padding(8)
                        }
                    )
                }
            }
            .background(primaryColor).ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct AddInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        AddInstructionView()
    }
}
