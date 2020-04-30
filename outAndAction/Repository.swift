//
//  Repository.swift
//  outAndAction
//
//  Created by Костя on 26.04.2020.
//  Copyright © 2020 Konstantin Evstafev. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class Repository {
    static func saveObject(_ place: Place){
        try! realm.write{
            realm.add(place)
        }
    }
    static func deleteObject(_ place: Place){
        
        try! realm.write{
            realm.delete(place)
        }
    }
    
    static func getAll() -> Results<Place>{
        
        try! realm.write{
            return realm.objects(Place.self)
        }
    }
    
    static func updateObject(_ oldPlace: Place?, newPlace: Place){
          try! realm.write{
            oldPlace?.name = newPlace.name
            oldPlace?.type = newPlace.type
            oldPlace?.location = newPlace.location
            oldPlace?.imageData = newPlace.imageData
          }
      }
    
}
