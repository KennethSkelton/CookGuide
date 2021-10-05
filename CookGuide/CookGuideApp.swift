//
//  CookGuideApp.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/9/21.
//

import SwiftUI
import RealmSwift

let app = RealmSwift.App(id: REALM_ID)

@main
struct CookGuideApp: SwiftUI.App {
    
    @StateObject var state = AppState()
    var body: some Scene {
        WindowGroup {
            AddRecipeView()
                .environmentObject(state)
        }
    }
}
