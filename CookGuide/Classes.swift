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


func login(username: String, password: String){
    print("Login start")
    /*
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
     */
    
    
    
    app.login(credentials: .emailPassword(email: username, password: password)) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                case .success(let user):
                    print("Login as \(user) succeeded!")
                    // Continue below
                    onLogin()
                }
            }
        }
    
    print("login end")
}

func onLogin() {
    print("on login")
    // Now logged in, do something with user
    let user = app.currentUser!
    // The partition determines which subset of data to access.
    let partitionValue = INGREDIENT_PARTITION_VALUE
    // Get a sync configuration from the user object.
    var configuration = user.configuration(partitionValue: partitionValue)
    // Open the realm asynchronously to ensure backend data is downloaded first.
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            print("on login close")
            onRealmOpened(realm)
        }
    }
}

func onRealmOpened(_ realm: Realm) {
    // Get all tasks in the realm
    print("Realm open")
    
    // Delete all from the realm
    /*
    try! realm.write {
        realm.deleteAll()
    }
    */
    
    // Add some tasks
    let task = IngredientObject(ingredient: "Eggs", recipeID: "12345")
    try! realm.write {
        realm.add(task)
    }
    
    let anotherTask = IngredientObject(ingredient: "Onion", recipeID: "67890")
    try! realm.write {
        realm.add(anotherTask)
    }
    // You can also filter a collection
    /*let tasksThatBeginWithA = tasks.filter("name beginsWith 'A'")
    print("A list of all tasks that begin with A: \(tasksThatBeginWithA)")*/
    // All modifications to a realm must happen in a write block.
    /*let taskToUpdate = tasks[0]
    try! realm.write {
        taskToUpdate.status = "InProgress"
    }*/
    
    /*
    let tasksInProgress = tasks.filter("status = %@", "InProgress")
    print("A list of all tasks in progress: \(tasksInProgress)")
    // All modifications to a realm must happen in a write block.
    let taskToDelete = tasks[0]
    try! realm.write {
        // Delete the QsTask.
        realm.delete(taskToDelete)
    }
    print("A list of all tasks after deleting one: \(tasks)")
    */
    app.currentUser?.logOut { (error) in
        // Logged out or error occurred
    }
    print("realm close")
}


func saveRealmObject(_ object: Object) {
    let realm = try! Realm()
    realm.add(object)
}


func saveRealmArray(_ objects: [Object]) {
    
    
    let realm = try! Realm()
    
    for object in objects{
       try! realm.write {
           realm.add(object)
       }
    }
}

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
    
    @Persisted var _id = UUID().uuidString
    
    
    convenience init(instruction: String, hasTimer: Bool, timerDuration: Int, recipeID: String){
        self.init()
        self.instruction = instruction
        self.hasTimer = hasTimer
        self.timerDuration = timerDuration
        self.recipeID = recipeID
    }
    
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}


class RecipeObject: Object {
    
    @Persisted var recipeName: String
    @Persisted var userID: String
    //@Persisted var ingredients: [IngredientObject]()
    //@Persisted var instructions: [InstructionObject]()
    @Persisted(primaryKey: true) var _id: ObjectId
    
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
}/*
public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
*/


struct localDatabase {
    
    var recipies = [RecipeObject]()
    var user: User = User()
}

var localdb = localDatabase()
