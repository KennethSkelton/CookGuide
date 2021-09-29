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
                        idx in Text(existingInstructions[idx].instruction)
                    }
                }
            VStack{
                HStack{
                    Text("Instruction: ")
                    TextField(
                        "Intruction",
                        text: $tempInstruction
                       )
                    
                }
                HStack{
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
                            let tempObject = InstructionObject()
                            tempObject.instruction = tempInstruction
                            tempObject.hasTimer = true
                            tempObject.timerDuration = intTimer ?? 0
                            existingInstructions.append(tempObject)
                        }
                        else{
                            let tempObject = InstructionObject()
                            tempObject.instruction = tempInstruction
                            tempObject.hasTimer = false
                            tempObject.timerDuration = 0
                            existingInstructions.append(tempObject)
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
                            let tempRecipe = RecipeObject()
                            tempRecipe.ingredients = ingredients
                            tempRecipe.instructions = existingInstructions
                            localdb.recipies.append(tempRecipe)
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
