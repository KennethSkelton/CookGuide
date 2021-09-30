//
//  Recipe View Initializer.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/14/21.
//

import Foundation
import RealmSwift
import SwiftUI


func createTestData() -> Array<RecipeObject>{
    var testRecipies = [RecipeObject](repeating: RecipeObject(), count: 5)
    
    let recipeNames = ["Meatloaf", "Spagetti and meatballs", "chicken stew", "chocolate chip cookies", "baked potato"]
    let allIngredients: [[String]] =
    [
        ["Bread","ground meat","Egg","Onion","Bell pepper"],
        ["Spagetti noodles", "tomato sauce", "onion", "ground meat", "red pepper flakes"],
        ["Chicken breast", "chicken broth", "bell peppers", "onion", "carrots"],
        ["flour", "eggs", "sugar", "milk", "chocolate chips", "vanilla extract", "salt", "baking powder","Butter"],
        ["potato", "butter"]
    ]
    
    let instructionInstructions: [[String]] =
    [
        ["Combine ingredients", "bake for 1 hour at 350"],
        ["Put in pot with water", "boil for 20 minutes", "put in onion and tomato sauce", "mold the ground meat into balls", "cook the meat at 350 for 10 minutes"],
        ["combine dry ingredients in a bowl", "combine wet ingredients in a seperate bowl", "mix untill uniform consistancy", "bake for 15 minutes at 375 degrees farenheit"],
        ["cut chicken into small pieces", "put all ingredients in pot at 300 degrees farenheit for 30 minutes"],
        ["potato + butter", "in oven for 10 minutes at 400 degrees farenheit"]
    ]
    
    let instructionHasTimer: [[Bool]] =
    [
        [false, true],
        [false, true, false, false, true],
        [false, false, false, true],
        [false, true],
        [false, true]
    ]
    
    let instructionTimerDuration: [[Int]] =
    [
        [0,60],
        [0,20,0,0,10],
        [0,0,0,15],
        [0,30],
        [0,10]
    ]
    
    
    var ingredients = [[IngredientObject?]](repeating: [IngredientObject](), count: 5)
    var instructions = [[InstructionObject?]](repeating: [InstructionObject](), count: 5)
 
    
    for i in 0...allIngredients.count-1{
        ingredients[i] = [IngredientObject?](repeating: nil, count: allIngredients[i].count)
        for j in 0...allIngredients[i].count-1{
            ingredients[i][j] = IngredientObject(ingredient: allIngredients[i][j])
        }
    }
    
    for i in 0...instructionInstructions.count-1{
        instructions[i] = [InstructionObject?](repeating: nil, count: instructionInstructions[i].count)
        for j in 0...instructionInstructions[i].count-1{
            instructions[i][j] = InstructionObject(instruction: instructionInstructions[i][j], hasTimer: instructionHasTimer[i][j], timerDuration: instructionTimerDuration[i][j])
        }
    }
    
    for i in 0...recipeNames.count-1{
        testRecipies[i] = RecipeObject(recipeName: recipeNames[i], ingredients: ingredients[i], instructions: instructions[i])
    }
    
    localdb.recipies = testRecipies
    return testRecipies
}

