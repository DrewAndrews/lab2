//
//  Premium.swift
//  lab2
//
//  Created by Andrey Rusinovich on 06.03.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Premium: Object {
    @objc dynamic var year: Int = 0
    @objc dynamic var festival: String = ""
    
    static func mapSelf(_ json: JSON) -> Premium {
        let premium = Premium()
        premium.festival = json["festival"].stringValue
        premium.year = json["year"].intValue
        return premium
    }
}
