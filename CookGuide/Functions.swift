//
//  Functions.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 10/1/21.
//

import Foundation
import RealmSwift


func signup(username: String, password: String) {
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
    }


func login(username: String, password: String){
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
}

func onLogin(){
    // Now logged in, do something with user
    let user = app.currentUser!
    print("From within onLogin",state.isLoggedIn())
    // The partition determines which subset of data to access.
    let partitionValue = INGREDIENT_PARTITION_VALUE
    // Get a sync configuration from the user object.
    var configuration = user.configuration(partitionValue: partitionValue)
    // Open the realm asynchronously to ensure backend data is downloaded first.
    print(Realm.Configuration.defaultConfiguration.fileURL!)
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            print("Realm Opened")
            
            
            
            // BY COMMENTING THIS OUT WE DONT CLOSE THE CONNECTION
            //onRealmOpened(realm)
        }
    }
}

func onRealmOpened(_ realm: Realm) {
    // Get all tasks in the realm
    
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
}


func saveRealmObject(_ object: Object) {
    
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
            print("Realm Opened")
            try! realm.write {
                realm.add(object)
            }
        }
    }
}

func updateRealmObject(_ object: Object) {
    
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
            print("Realm Opened")
            try! realm.write {
                realm.add(object, update: .modified)
            }
        }
    }
}


func saveRealmArray(_ objects: [Object]) {
    
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
            print("Realm Opened")
    
            for object in objects{
               try! realm.write {
                   realm.add(object)
               }
            }
        }
    }
}

func updateRealmArray(_ objects: [Object]) {
    
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
            print("Realm Opened")
    
            for object in objects{
               try! realm.write {
                   realm.add(object, update: .modified)
               }
            }
        }
    }
}

func fractionReplacer(input: String) -> String{
    var output = input
    output = output.replacingOccurrences(of: "??", with: " one half ")
    output = output.replacingOccurrences(of: "???", with: " one third ")
    output = output.replacingOccurrences(of: "??", with: " one fourth ")
    output = output.replacingOccurrences(of: "???", with: " one fifth ")
    output = output.replacingOccurrences(of: "???", with: " one sixth ")
    output = output.replacingOccurrences(of: "???", with: " one seventh ")
    output = output.replacingOccurrences(of: "???", with: " one eighth ")
    output = output.replacingOccurrences(of: "???", with: " one ninth ")
    output = output.replacingOccurrences(of: "???", with: " one tenth ")
    output = output.replacingOccurrences(of: "???", with: " two thirds ")
    output = output.replacingOccurrences(of: "??", with: " three quarters ")
    output = output.replacingOccurrences(of: "???", with: " three eighths ")
    
    return output
}

func updateLocalDatabaseRecipe(object: RecipeObject){
    for element in localdb.recipes {
        if(object._id == element._id){
            if let index = localdb.recipes.firstIndex(of: element){
                localdb.recipes[index] = object
            }
        }
    }
}

func updateLocalDatabaseRecipeArray(objects: [RecipeObject]){
    for object in objects{
        for element in localdb.recipes {
            if(object._id == element._id){
                if let index = localdb.recipes.firstIndex(of: element){
                    localdb.recipes[index] = object
                }
            }
        }
    }
}
func updateLocalDatabaseIngredientArray(objects: [IngredientObject]){
    
    for object in objects{
        for element in localdb.ingredients {
            if(object._id == element._id){
                if let index = localdb.ingredients.firstIndex(of: element){
                    localdb.ingredients[index] = object
                }
            }
        }
    }
}
func updateLocalDatabaseInstructionArray(objects: [InstructionObject]){
    for object in objects{
        for element in localdb.instructions {
            if(object._id == element._id){
                if let index = localdb.instructions.firstIndex(of: element){
                    localdb.instructions[index] = object
                }
            }
        }
    }
}


func findTimerDuration(input: String) -> String{
    
    var timerDuration = "PT0M";
    var inputLower = input.lowercased()
    var timerConversions = [
        "second" : 0.0167,
        "seconds" : 0.0167,
        "minute" : 1,
        "minutes" : 1,
        "hour" : 60,
        "hours" : 60
    ]
    
    var arrayString = inputLower.split(separator: " ")
    
    for index in 0..<arrayString.count{
        if(timerConversions[String(arrayString[index])] != nil){
            for index2 in stride(from: index, through: 0, by: -1){
                if(isNumbers(input : String(arrayString[index2]))){
                    
                    var minuteMultiplier = timerConversions[String(arrayString[index])] ?? 0
                    var numberOfMinutes = Double(String(arrayString[index2])) ?? 0 * minuteMultiplier
                    
                    timerDuration = "PT" + String(numberOfMinutes) + "M"
                }
            }
        }
    }
    
    return timerDuration
}

func isNumbers(input: String) -> Bool{
    
    for letter in input{
        if(!letter.isNumber){
            return false
        }
    }
    return true
}


/*
func queryAllUsers() -> Any{
    var response: Any = 0
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
            try! realm.write {
                response = realm.objects(User.self)
            }
        
        }
    }
    return response
}
*/
