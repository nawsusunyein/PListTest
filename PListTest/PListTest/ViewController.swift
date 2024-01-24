//
//  ViewController.swift
//  PListTest
//
//  Created by Naw Su Su Nyein on 7/5/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import SwiftToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let fruits = getFruitPList(withName: "Fruit"){
            print(fruits)
            print("Value : \(fruits.Org)")
            print("Value : \(fruits.Ki)")
        }
        
        print("blah blah PR test")
        self.createWebPropertyList()
        
        let test = SwiftToast(text: "This is a Toast")
        present(test, animated: true)
        
        #if LOCAL
            print("it is local scheme")
        #elseif DEV
            print("it is dev scheme")
        #elseif STAGING
            print("it is staging scheme")
        #elseif QA
            print("it is QA scheme")
        #elseif PRODUCTION
            print("it is production scheme")
        #endif
        
        print("url : \(AppConfig.baseURL)")
    }

    func getFruitPList(withName name : String) -> Fruits?{
        if let path = Bundle.main.path(forResource: name, ofType: "plist"),let xml = FileManager.default.contents(atPath: path),
            let preferences = try? PropertyListDecoder().decode(Fruits.self, from: xml){
           return preferences
        }
        
        return nil
    }
    
    func createWebPropertyList(){
        let webPropertyList = WebProperty(host:"https://www.google.com",path: "/your-name",port: "8080")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("WebProperty.plist")
        
        do{
            let data = try encoder.encode(webPropertyList)
            try data.write(to: path)
        }catch{
            print(error)
        }
    }
}

