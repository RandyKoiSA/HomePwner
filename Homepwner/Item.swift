//
//  Item.swift
//  Homepwner
//
//  Created by Randy Le on 4/6/19.
//  Copyright © 2019 Project Koisa. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    
    init(name: String, valueInDollars: Int, serialNumber: String?){
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        
        super.init()
    }
    
    convenience init(random: Bool = false){
        if random{
            // initializer sets of random adjectives and nouns
            let adjectives : [String] = ["Fluffy", "Rusty", "Shiny"]
            let nouns : [String] = ["Bear", "Spork", "Mac"]
            
            // create random number with the amount of items in adjectives list
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            
            // create random number with the amount of items in nouns list
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            // set random name together
            let randomName: String = "\(randomAdjective) \(randomNoun)"
            
            // get random number for serial number and amountInDollars
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
}
