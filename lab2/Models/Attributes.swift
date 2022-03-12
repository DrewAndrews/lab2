//
//  Attributes.swift
//  lab2
//
//  Created by Andrey Rusinovich on 06.03.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Attributes: Object {
    @objc dynamic var author: String = ""
    var casts = List<String>()
    @objc dynamic var producer: String = ""
    @objc dynamic var premium: Premium?
    
    static func mapSelf(_ json: JSON) -> Attributes {
        let attributes = Attributes()
        attributes.author = json["author"].stringValue
        attributes.producer = json["producer"].stringValue
        let castsList = List<String>()
        let jsonCasts = json["casts"].arrayValue
        jsonCasts.forEach {
            castsList.append($0.stringValue)
        }
        attributes.casts = castsList
        attributes.premium = Premium.mapSelf(json["premium"])
        return attributes
    }
}
