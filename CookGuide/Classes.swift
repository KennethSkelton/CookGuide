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
}




func saveRealmArray(_ objects: [Object]) {
    
    
    }

@objcMembers class IngredientObject: Object, ObjectKeyIdentifiable {
    
    dynamic var ingredient: String = ""
    dynamic var _id = UUID().uuidString
    
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
}
