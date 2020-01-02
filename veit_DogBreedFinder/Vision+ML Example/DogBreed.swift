//
//  DogBreed.swift
//  Dog Breed Finder
//
//  Created by Gabriel Veit on 11/29/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class DogBreed : NSObject, NSCoding {
    private var name:String = ""
    private var bredFor:String = ""
    private var lifespan:String = ""
    private var temperament:String = ""
    private var weight:String = ""
    private var height:String = ""
    
    init(name:String, bredFor:String, lifespan:String, temperament:String, weight:String, height:String) {
        super.init()
        self.setName(name:name)
        self.setBredFor(bredFor:bredFor)
        self.setLifespan(lifespan:lifespan)
        self.setTemperament(temperament:temperament)
        self.setWeight(weight:weight)
        self.setHeight(height:height)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let bredFor = aDecoder.decodeObject(forKey: "bredFor") as! String
        let lifespan = aDecoder.decodeObject(forKey: "lifespan") as! String
        let temperament = aDecoder.decodeObject(forKey: "temperament") as! String
        let weight = aDecoder.decodeObject(forKey: "weight") as! String
        let height = aDecoder.decodeObject(forKey: "height") as! String
        
        self.init(name: name, bredFor: bredFor, lifespan: lifespan, temperament: temperament, weight: weight, height: height)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.bredFor, forKey: "bredFor")
        aCoder.encode(self.lifespan, forKey: "lifespan")
        aCoder.encode(self.temperament, forKey: "temperament")
        aCoder.encode(self.weight, forKey: "weight")
        aCoder.encode(self.height, forKey: "height")
    }
    
    func getName() -> String {
        return self.name
    }
    func setName(name:String) {
        self.name = name
    }
    
    func getBredFor() -> String {
        return self.bredFor
    }
    func setBredFor(bredFor:String) {
        self.bredFor = bredFor
    }
    
    func getLifespan() -> String {
        return self.lifespan
    }
    func setLifespan(lifespan:String) {
        self.lifespan = lifespan
    }
    
    func getTemperament() -> String {
        return self.temperament
    }
    func setTemperament(temperament:String) {
        self.temperament = temperament
    }
    
    func getWeight() -> String {
        return self.weight
    }
    func setWeight(weight:String) {
        self.weight = weight
    }
    
    func getHeight() -> String {
        return self.height
    }
    func setHeight(height:String) {
        self.height = height
    }
}
