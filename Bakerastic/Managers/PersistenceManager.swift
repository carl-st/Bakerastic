//
//  PersistenceManager.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import RealmSwift

class PersistenceManager {
    static let sharedInstance = PersistenceManager(realm: nil)
    var realm: Realm

    init(realm: Realm?) {
        if let realm = realm {
            self.realm = realm
        } else {
            var config = Realm.Configuration(
                    schemaVersion: 2,
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion < 1 {

                        }
                    })

            // It's easier to have it enabled for development. Use migration blocks for production scheme.
            config.deleteRealmIfMigrationNeeded = true
            Realm.Configuration.defaultConfiguration = config
            self.realm = try! Realm()
        }

        debugPrint("Realm file path: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
    
    func createOrUpdate<T: Object>(_ object: T) {
        createOrUpdate(object, realm: realm)
    }
    
    func createOrUpdate<T: Object>(_ array: [T]) {
        createOrUpdate(array, realm: realm)
    }
    
    func createOrUpdate<T: Object>(_ object: T, realm: Realm) {
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func createOrUpdate<T: Object>(_ array: [T], realm: Realm) {
        try! realm.write {
            realm.add(array, update: true)
        }
    }
    
    

}

