//
//  PersistenceManager.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/19/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import Foundation
import RealmSwift

final class PersistenceManager {
    
    private init() {}
    
    static let instance = PersistenceManager()
    
    func photos() -> Results<Photo>? {
        let realm = try? Realm()
        return realm?.objects(Photo.self).sorted(byKeyPath: #keyPath(Photo.date), ascending: false)
    }
    
    func save(photoData data: Data, forKeyword keyword: String) {
        let realm = try? Realm()
        try? realm?.write {
            let photo = Photo()
            photo.keyword = keyword
            photo.data = data
            photo.date = Date()
            realm?.add(photo)
        }
    }
}
