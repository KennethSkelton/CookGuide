//
//  RecipeInformationView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/30/21.
//

import SwiftUI

struct RecipeInformationView: View {
    
    var recipe = RecipeObject()
    
    var body: some View {
        VStack{
            Text(recipe.recipeName)
        }
    }
}

struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView()
    }
}
