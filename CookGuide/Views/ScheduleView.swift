//
//  ScheduleView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 1/22/22.
//

import SwiftUI
import Foundation




struct ScheduleView: View {
    
    @State var recipeIDIndex = 0
    @State var date = Date()
    
    @State var recipe = RecipeObject()
    
    @State var mealEvents = localdb.mealEvents
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter
    }();
    
    
    var body: some View {
        
        VStack{
            
            List(){
                if(mealEvents.count == 0){
                    Text("No meals planned")
                }
                ForEach(0..<mealEvents.count, id: \.self){
                    idx in
                    
                    HStack{
                        Text(mealEvents[idx].recipeName)
                        Text(mealEvents[idx].dateString)
                        
                        
                    }
                }
            }
            
            Form {
                DatePicker("Meal Date", selection: $date, in: Date()...)
                Picker(selection: $recipeIDIndex, label: Text("Recipes")) {
                    ForEach(0 ..< localdb.recipes.count) {
                        idx in
                        Text(localdb.recipes[idx].recipeName)
                    }
                }
                
                
                Button(action: {
                    
                        
                    
                    var mealEvent = MealEventObject(recipeID: localdb.recipes[recipeIDIndex].recipeID, dateString: dateFormatter.string(from: date))
                        localdb.mealEvents.append(mealEvent)
                    
                        mealEvents = localdb.mealEvents
                        
                        saveRealmObject(mealEvent)
                    }) {
                        Text("Add Meal")
                }
            }
            
            
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
