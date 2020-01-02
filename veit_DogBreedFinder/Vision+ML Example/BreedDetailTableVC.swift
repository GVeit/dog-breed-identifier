//
//  BreedDetailTableVC.swift
//  Dog Breed Finder
//
//  Created by Gabriel Veit on 11/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation


import UIKit

class BreedDetailTableVC: UITableViewController {
    
    private var name:String = ""
    private var breedFor:String = ""
    private var lifespan:String = ""
    private var temperament:String = ""
    private var weight:String = ""
    private var height:String = ""

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bredForLabel: UILabel!
    @IBOutlet weak var lifespanLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var addToFavoritesLabel: UILabel!
    @IBOutlet weak var addToFavoritesCell: UITableViewCell!
    
    var dogBreed:DogBreed!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //print all facts about each breed
        nameLabel.text = dogBreed.getName()
        bredForLabel.text = "Bred For: " + dogBreed.getBredFor()
        lifespanLabel.text = "Lifespan: " + dogBreed.getLifespan()
        temperamentLabel.text = "Temperament: " + dogBreed.getTemperament()
        weightLabel.text = "Weight: " + dogBreed.getWeight() + "lbs"
        heightLabel.text = "Height: " + dogBreed.getHeight() + "in"
        
        let encodedBreeds = defaults.object(forKey: "favoredBreeds") as? Data ?? Data()
        let favoredBreeds = NSKeyedUnarchiver.unarchiveObject(with: encodedBreeds) as? [DogBreed] ?? [DogBreed]()
        
        if favoredBreeds.count > 0 {
            //if dog breed is already in favoredBreeds list, note it
            var found = false;
            for i in 0..<favoredBreeds.count {
                if favoredBreeds[i].getName() == self.dogBreed.getName() {
                    found = true;
                    addToFavoritesLabel.text = "Remove from Favorites"
                    break;
                }
            }
            if (!found) {
                addToFavoritesLabel.text = "Add to Favorites"
            }
        } else {
            addToFavoritesLabel.text = "Add to Favorites"
        }

        
    }
        
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        if cell == addToFavoritesCell {
            let encodedBreeds = defaults.object(forKey: "favoredBreeds") as? Data ?? Data()
            let favoredBreeds = NSKeyedUnarchiver.unarchiveObject(with: encodedBreeds) as? [DogBreed] ?? [DogBreed]()
            
            var message = "\(self.dogBreed.getName()) Added to Favorites";
            
            if favoredBreeds.count > 0 {
                var newFavoredBreeds = favoredBreeds
                
                //if dog breed is already in favoredBreeds list, remove it. Else, add it.
                var found = false;
                for i in 0..<favoredBreeds.count {
                    if newFavoredBreeds[i].getName() == self.dogBreed.getName() {
                        newFavoredBreeds.remove(at : i)
                        found = true;
                        message = "\(self.dogBreed.getName()) Removed from Favorites";
                        addToFavoritesLabel.text = "Add to Favorites"
                        break;
                    }
                }
                if (!found) {
                    //add favorite breed to the favorite page
                    newFavoredBreeds.append(self.dogBreed)
                    addToFavoritesLabel.text = "Remove from Favorites"
                }
                let data = NSKeyedArchiver.archivedData(withRootObject: newFavoredBreeds)
                defaults.set(data, forKey: "favoredBreeds")
                defaults.synchronize()
            } else {
                var newFavoredBreeds:[DogBreed] = []
                newFavoredBreeds.append(self.dogBreed)
                let data = NSKeyedArchiver.archivedData(withRootObject: newFavoredBreeds)
                defaults.set(data, forKey: "favoredBreeds")
                defaults.synchronize()
                addToFavoritesLabel.text = "Remove from Favorites"
            }
            
            //alert the user that the favorite breed was added to the favorite page
            let alert = UIAlertController(title: "Favorites", message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
