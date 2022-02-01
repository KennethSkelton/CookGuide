//
//  Classes.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import Foundation
import RealmSwift
import SwiftUI

var state = AppState()


class IngredientObject: Object {
    
    @Persisted var ingredient: String
    @Persisted var recipeID: String
    
    @Persisted var _id = UUID().uuidString
    
    
    convenience init(ingredient: String, recipeID: String){
        self.init()
        self.ingredient = ingredient
        self.recipeID = recipeID
    }
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}


class InstructionObject: Object {
    

    @Persisted var instruction: String
    @Persisted var hasTimer: Bool
    @Persisted var timerDuration: Int
    @Persisted var recipeID: String
    @Persisted var order: Int
    
    @Persisted var _id = UUID().uuidString
    
    
    convenience init(instruction: String, hasTimer: Bool, timerDuration: Int, order:Int? = 0, recipeID: String){
        self.init()
        self.instruction = instruction
        self.hasTimer = hasTimer
        self.timerDuration = timerDuration
        self.recipeID = recipeID
        self.order = order ?? 0
    }
    
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}


class RecipeObject: Object {
    
    @Persisted var recipeName: String
    @Persisted var userID: String
    @Persisted var recipeID = UUID().uuidString
    //@Persisted var ingredients: [IngredientObject]()
    //@Persisted var instructions: [InstructionObject]()
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    /*
    convenience init(recipeName: String, ingredients: [IngredientObject](), instructions: [InstructionObject]()){
        self.recipeName = recipeName
        self.ingredients = ingredients
        self.instructions = instructions
    }
     */
    
    convenience init(recipeName: String, userID: String){
        self.init()
        self.recipeName = recipeName
        self.userID = userID
    }
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class User: Object {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var partition = "" // "user=_id"
    @Persisted var userName = ""
    @Persisted var lastSeenAt: Date?
    @Persisted var presence = "Off-Line"

    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
}

class MealEventObject: Object {
    @Persisted var recipeName: String
    @Persisted var recipeID: String
    @Persisted var dateString: String
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    convenience init(recipeID: String, dateString: String) {
        self.init()
        self.recipeID = recipeID
        self.dateString = dateString
        
        for recipe in localdb.recipes {
            if(recipe.recipeID == self.recipeID){
                self.recipeName = recipe.recipeName
            }
        }
    }
    
    
    
}



enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}/*
public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
*/


struct localDatabase {
    
    var recipes = [RecipeObject]()
    var instructions = [InstructionObject]()
    var ingredients = [IngredientObject]()
    var mealEvents = [MealEventObject]()
    var user: Any?
}


