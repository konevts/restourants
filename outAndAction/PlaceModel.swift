//
//  PlaceModel.swift
//  Fit Twins
//
//  Created by Костя on 19.04.2020.
//  Copyright © 2020 Konstantin Evstafev. All rights reserved.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.type = type
        self.location = location
        self.imageData = imageData
        
    }
}
