//
//  FavoriteTableVC.swift
//  Dog Breed Finder
//
//  Created by Gabriel Veit on 12/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation


import UIKit

class FavoriteTableVC: UITableViewController {
    
    let defaults = UserDefaults.standard
    var favoriteBreeds:[DogBreed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshFavoriteBreeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavoriteBreeds()
    }

    func refreshFavoriteBreeds() {
        let encodedBreeds = defaults.object(forKey: "favoredBreeds") as? Data ?? Data()
        let favoredBreeds = NSKeyedUnarchiver.unarchiveObject(with: encodedBreeds) as? [DogBreed] ?? [DogBreed]()
        
        if favoredBreeds.count > 0 {
            self.favoriteBreeds = favoredBreeds
        } else {
            self.favoriteBreeds = []
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteBreeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBreed", for: indexPath)

        // Configure the cell...
        let dogBreed = self.favoriteBreeds[indexPath.row]
        cell.textLabel?.text = dogBreed.getName()
                
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get the new view controller using segue.destinationViewController.
        //pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow
        
        let dogBreed = self.favoriteBreeds[indexPath!.row]
        
        //create new BreedDetailTableVC and set its properties
        let detailViewController = segue.destination as! BreedDetailTableVC
        detailViewController.title = dogBreed.getName()
        detailViewController.dogBreed = dogBreed
    }


}
