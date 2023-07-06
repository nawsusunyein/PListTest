//
//  ViewController.swift
//  PListTest
//
//  Created by Naw Su Su Nyein on 7/5/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableviewCountryList : UITableView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var limit = 20
    var totalCountries = 0
    var index = 0
    var isStillLoad : Bool = true
    
    
    var displayCountries : [String] = Array()
    var country_list = ["aaa","bbb","ccc","ddd","eee","fff","hhh","iii","jjj","kkk","lll","mmm","nnn","ooo","ppp","qqq","rrr","sss","ttt","uuu","vvv","www","xxx","yyy","zzz","1aaa","1bbb","1ccc","1ddd","1eee","1fff","1hhh","1iii","1jjj","1kkk","1lll","1mmm","1nnn","1ooo","1ppp","1qqq","1rrr","1sss","1ttt","1uuu","1vvv","1www","1xxx","1yyy","1zzz","2aaa","2bbb","2ccc","2ddd","2eee","2fff","2hhh","2iii","2jjj","2kkk","2lll","2mmm","2nnn","2ooo","2ppp","2qqq","2rrr","2sss","2ttt","2uuu","2vvv","2www","2xxx","2yyy","2zzz","3aaa","3bbb","3ccc","3ddd","3eee","3fff","3hhh","3iii","3jjj","3kkk","3lll","3mmm","3nnn","3ooo","3ppp","3qqq","3rrr","3sss","3ttt","3uuu","3vvv","3www","3xxx","3yyy","3zzz","4aaa","4bbb","4ccc","4ddd","4eee","4fff","4hhh","4iii","4jjj","4kkk","4lll","4mmm","4nnn","4ooo","4ppp","4qqq","4rrr","4sss","4ttt","4uuu","4vvv","4www","4xxx","4yyy","4zzz","5aaa","5bbb","5ccc","5ddd","5eee","5fff","5hhh","5iii","5jjj","5kkk","5lll","5mmm","5nnn","5ooo","5ppp","5qqq","5rrr","5sss","5ttt","5uuu","5vvv","5www","5xxx","5yyy","5zzz","6aaa","6bbb","6ccc","6ddd","6eee","6fff","6hhh","6iii","6jjj","6kkk","6lll","6mmm","6nnn","6ooo","6ppp","6qqq","6rrr","6sss","6ttt","6uuu","6vvv","6www","6xxx","6yyy","6zzz","7aaa","7bbb","7ccc","7ddd","7eee","7fff","7hhh","7iii","7jjj","7kkk","7lll","7mmm","7nnn","7ooo","7ppp","7qqq","7rrr","7sss","7ttt","7uuu","7vvv","7www","7xxx","7yyy","7zzz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//
//        if let fruits = getFruitPList(withName: "Fruit"){
//            print(fruits)
//            print("Value : \(fruits.Org)")
//            print("Value : \(fruits.Ki)")
//        }
//
//        print("blah blah PR test")
//        self.createWebPropertyList()
        totalCountries = country_list.count
        while index < limit {
            displayCountries.append(country_list[index])
            index = index + 1
        }
        loadingView.isHidden = true
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

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewCountryList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1) \(displayCountries[indexPath.row])"
        if(indexPath.row == displayCountries.count - 1) {
            isStillLoad = false
        } else {
            isStillLoad = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("y : \(tableView.contentOffset.y), cotent size : \(tableView.contentSize.height), frame : \(tableView.frame.size.height)")
        let offset = tableView.contentOffset.y
        let difference = tableView.contentSize.height - tableView.frame.size.height
        if(isTableViewScrolledToBottom() == true) {
            loadingView.isHidden = false
                        var index = displayCountries.count - 1
                        if(index + 20 > country_list.count - 1) {
                            limit = country_list.count - index
                        } else {
                            limit = index + 20
                        }
            
                        while index < limit {
                            displayCountries.append(country_list[index])
                            index += 1
                        }
                        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
        }
    }
    
    @objc func loadTable() {
        loadingView.isHidden = true
        tableviewCountryList.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("isReachToEnd : \(isTableViewScrolledToBottom())")
    }
    
    func isTableViewScrolledToBottom() -> Bool {
        let tableHeight = tableviewCountryList.bounds.size.height
        let contentHeight = tableviewCountryList.contentSize.height
        let insetHeight = tableviewCountryList.contentInset.bottom

        let yOffset = tableviewCountryList.contentOffset.y
        let yOffsetAtBottom = yOffset + tableHeight - insetHeight

        return yOffsetAtBottom > contentHeight
    }
}
