//
//  CookGuideApp.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/23/21.
//

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject {
    
    @Published var error: String?
    @Published var busyCount = 0
    
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    let userRealmPublisher = PassthroughSubject<Realm, Error>()
    var cancellables = Set<AnyCancellable>()

    var user: User?

    func isLoggedIn() -> Bool {
        return app.currentUser != nil && app.currentUser?.state == .loggedIn
    }
    
    func isNotLoggedIn() -> Bool{
        return !isLoggedIn()
    }
    


    init() {
        _  = app.currentUser?.logOut()
        initLoginPublisher()
        initUserRealmPublisher()
        initLogoutPublisher()
    }
    
    func initLoginPublisher() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)
    }
    
    func initUserRealmPublisher() {
        userRealmPublisher
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in and open user realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("User Realm User file location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(User.self).first
                do {
                    try realm.write {
                        self.user?.presenceState = .onLine
                    }
                } catch {
                    self.error = "Unable to open Realm write transaction"
                }
            })
            .store(in: &cancellables)
    }
    
    func initLogoutPublisher() {
        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.user = nil
            })
            .store(in: &cancellables)
    }
}
