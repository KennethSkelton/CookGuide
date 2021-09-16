//
//  Classes.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/16/21.
//

import Foundation
import RealmSwift

func saveRealmArray(_ objects: [Object]) {
    
    let app = App(id: REALM_ID)

    // Log in anonymously.
    app.login(credentials: Credentials.anonymous) { (result) in
        // Remember to dispatch back to the main thread in completion handlers
        // if you want to do anything on the UI.
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
            case .success(let user):
                print("Login as \(user) succeeded!")
                
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
                    case .success(let realm):
                        break
                    }
                }
            }
        }
    }
    
    
        let realm = try! Realm()
        try! realm.write {
            realm.add(objects)
        }
    }

class IngredientObject: Object {
    
    @Persisted var ingredient = ""
    //@Persisted var _id = ""
}
