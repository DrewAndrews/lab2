//
//  ViewController.swift
//  lab2
//
//  Created by Andrey Rusinovich on 06.03.2022.
//

import UIKit
import RealmSwift
import SwiftyJSON

class ViewController: UIViewController {
    
    lazy var realm = try! Realm()
    lazy var films: Results<Film> = { self.realm.objects(Film.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL?.path)
        try! realm.write {
            realm.deleteAll()
        }
        getFilmsFromLocal()
        firstPredicate()
        secondPredicate()
        thirdPredicate(author: "Peter Cockson", studio: "Home studio")
        fourthPredicate(title: "Home alone")
        fifthPredicate(author: "Peter Cockson")
    }
    
    private func getFilmsFromLocal() {
        if let path = Bundle.main.path(forResource: "films", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let json = try JSON(data: data)
                loadFilmToDatabase(json: json)
            } catch {
                print("ERROR")
            }
        }
    }
    
    private func loadFilmToDatabase(json: JSON) {
        let jsonFilms = json["films"].arrayValue.map { Film.mapSelf($0) }
        try! realm.write {
            realm.add(jsonFilms)
        }
    }
    
    private func firstPredicate() {
        print("1. ", terminator: "")
        var lengths: [Int] = []
        realm.objects(Film.self).forEach {
            lengths.append($0.attributes!.casts.count)
        }
        let minLength = lengths.min()
        realm.objects(Film.self).filter("attributes.casts.@count = \(minLength!)").forEach {
            print($0.attributes!.producer)
        }
    }
    
    private func secondPredicate() {
        print("2. ", terminator: "")
        realm.objects(Film.self).filter("attributes.premium != nil").forEach {
            print($0.attributes!.author, $0.attributes!.producer)
        }
    }
    
    private func thirdPredicate(author: String, studio: String) {
        print("3. ", terminator: "")
        realm.objects(Film.self).filter("attributes.author = '\(author)' AND studio = '\(studio)'").forEach {
            print($0.title)
        }
    }
    
    private func fourthPredicate(title: String) {
        print("4. ", terminator: "")
        realm.objects(Film.self).filter("title = '\(title)'").forEach {
            $0.attributes?.casts.forEach {
                print($0, terminator: ", ")
            }
        }
        print()
    }
    
    private func fifthPredicate(author: String) {
        print("5. ", terminator: "")
        realm.objects(Film.self).filter("attributes.author = '\(author)'").forEach {
            print($0.studio)
        }
    }
}

