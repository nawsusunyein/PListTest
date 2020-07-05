//
//  ViewController.swift
//  PListTest
//
//  Created by Naw Su Su Nyein on 7/5/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let fruits = getFruitPList(withName: "Fruit"){
            print(fruits)
            print("Value : \(fruits.Org)")
            print("Value : \(fruits.Ki)")
        }
    }

    func getFruitPList(withName name : String) -> Fruits?{
        if let path = Bundle.main.path(forResource: name, ofType: "plist"),let xml = FileManager.default.contents(atPath: path),
            let preferences = try? PropertyListDecoder().decode(Fruits.self, from: xml){
           return preferences
        }
        
        return nil
    }
}

