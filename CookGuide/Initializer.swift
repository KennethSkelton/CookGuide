//
//  Recipe View Initializer.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/14/21.
//

import Foundation
import RealmSwift
import SwiftUI

var localdb = localDatabase()

func initilizeDatabase(){
    
    localdb.user = app.currentUser
    print("Local DB user", localdb.user)
    
    setAllRecipes()
    setAllIngredients()
    setAllInstructions()
}

func setAllRecipes(){
    
    let user = app.currentUser!
    // The partition determines which subset of data to access.
    let partitionValue = INGREDIENT_PARTITION_VALUE
    // Get a sync configuration from the user object.
    var configuration = user.configuration(partitionValue: partitionValue)
    
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            print("Realm Opened")
            for recipe in realm.objects(RecipeObject.self){
                localdb.recipes.append(recipe)
            }
        }
    }
}

func setAllIngredients(){
    
    let user = app.currentUser!
    // The partition determines which subset of data to access.
    let partitionValue = INGREDIENT_PARTITION_VALUE
    // Get a sync configuration from the user object.
    var configuration = user.configuration(partitionValue: partitionValue)
    
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            print("Realm Opened")
            for ingredient in realm.objects(IngredientObject.self){
                localdb.ingredients.append(ingredient)
            }
        }
    }
}

func setAllInstructions(){
    
    let user = app.currentUser!
    // The partition determines which subset of data to access.
    let partitionValue = INGREDIENT_PARTITION_VALUE
    // Get a sync configuration from the user object.
    var configuration = user.configuration(partitionValue: partitionValue)
    
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            print("Realm Opened")
            for instruction in realm.objects(InstructionObject.self){
                localdb.instructions.append(instruction)
            }
        }
    }
}




