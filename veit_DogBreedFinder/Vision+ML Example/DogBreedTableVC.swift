//
//  DogBreedTableVC.swift
//  Dog Breed Finder
//
//  Created by Gabriel Veit on 11/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DogBreedTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // warning Incomplete implementation, return the number of rows
        return 3
    }

    //display all dog breeds from the dog api
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "German Shepherd"
        return cell
    }
}
