//
//  Classes.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import Foundation
import RealmSwift

var state = AppState()

func signup(username: String, password: String) {
    print("Signup start")
        if username.isEmpty || password.isEmpty {
            return
        }
        state.error = nil
        app.emailPasswordAuth.registerUser(email: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    state.error = error.localizedDescription
                }
            }, receiveValue: {
                state.error = nil
                login(username: username, password: password)
            })
            .store(in: &state.cancellables)
    print("Signup end")
    }


func login(username: String, password: String) -> App{
    print("Login start")
    app.login(credentials:
                .emailPassword(email: username, password: password))
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        state.error = error.localizedDescription
                    }
                }, receiveValue: {
                    state.loginPublisher.send($0)
                })
                .store(in: &state.cancellables)
    print("login end")
    return app
}




func saveRealmArray(_ objects: [Object]) {
    
    
    let realm = try! Realm()
    
    for object in objects{
       try! realm.write {
           realm.add(object)
       }
    }
}

class IngredientObject {
    
    dynamic var ingredient: String
    dynamic var _id = UUID().uuidString
    
    init(){
        ingredient = ""
    }
    
    init(ingredient: String){
        self.ingredient = ingredient
    }
    
    static func primaryKey() -> String? {
        return "_id"
    }
}


class InstructionObject {
    
    dynamic var instruction: String = ""
    dynamic var hasTimer: Bool = false
    dynamic var timerDuration: Int = 0;
    dynamic var _id = UUID().uuidString
    
    init(){
        instruction = ""
        hasTimer = false
        timerDuration = 0
    }
    
    init(instruction: String, hasTimer: Bool, timerDuration: Int){
        self.instruction = instruction
        self.hasTimer = hasTimer
        self.timerDuration = timerDuration
    }
    
    
    static func primaryKey() -> String? {
        return "_id"
    }
}


class RecipeObject {
    
    dynamic var recipeName: String
    dynamic var ingredients: [IngredientObject]
    dynamic var instructions: [InstructionObject]
    dynamic var _id = UUID().uuidString
    
    init(){
        self.recipeName = "name"
        self.ingredients = [IngredientObject]()
        self.instructions = [InstructionObject]()
    }
    
    init(recipeName: String, ingredients: [IngredientObject], instructions: [InstructionObject]){
        self.recipeName = recipeName
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    static func primaryKey() -> String? {
        return "_id"
    }

}

class User: Object, ObjectKeyIdentifiable {
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

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}

struct localDatabase {
    
    var recipies = [RecipeObject]()
    var user: User = User()
}

var localdb = localDatabase()
