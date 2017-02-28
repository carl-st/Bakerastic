//
//  ContentViewModel.swift
//  Bakerastic
//
//  Created by Karol Stępień on 28.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import RealmSwift

class ContentViewModel {
    var contentNotificationToken: NotificationToken? = nil
    var persistenceManager: PersistenceManager
    var reload: (() -> Void)?
    var content: Results<RemoteContent>
    var starViews: [DraggableView] = []

    init(reload: (() -> Void)? = nil, persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        self.reload = reload
        self.persistenceManager = persistence

        self.content = persistence.getContent()

        let realm = try! Realm()
        let results = realm.objects(RemoteContent.self)
        contentNotificationToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let reload = reload else {
                return
            }
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.content = persistence.getContent()

                reload()
                break
            case .error(let error):
                fatalError("\(error)")

                break
            }
        }
    }

    deinit {
        contentNotificationToken?.stop()
    }

}
