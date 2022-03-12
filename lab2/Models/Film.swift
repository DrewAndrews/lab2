//
//  Film.swift
//  lab2
//
//  Created by Andrey Rusinovich on 06.03.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Film: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var year: Int = 0
    @objc dynamic var studio: String = ""
    @objc dynamic var attributes: Attributes?
    
    static func mapSelf(_ json: JSON) -> Film {
        let film = Film()
        film.title = json["title"].stringValue
        film.year = json["year"].intValue
        film.studio = json["studio"].stringValue
        film.attributes = Attributes.mapSelf(json["attributes"])
        return film
    }
}
