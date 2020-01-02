//
//  ResultsTableVC.swift
//  Dog Breed Finder
//
//  Created by Gabriel Veit on 11/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ResultsTableVC: UITableViewController {
    var dogBreeds = [DogBreed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    // MARK: - Helpers
    func loadData(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //the dog api
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")
        
        //set up the dataTask and callback function
        let dataTask = session.dataTask(with: url! as URL, completionHandler:{
            (data:Data?, response:URLResponse?, error:Error?) -> Void in
            
            //is there an error? Bail out!
            guard error == nil else{
                print("error = \(String(describing: error))")
                return
            }
            
            //is there no data? Bail out!
            guard let data = data else{
                print("No data!")
                return
            }

            //print raw data in the back system
            print("response = \(String(describing: response))")
            
            //try to convert the JSON text to a Swift Dictionary
            guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [Any] else{
                print("JSON would not parse!")
                return
            }
            print("json=\(String(describing: json))")
            
            // all the code in this completion handler is running
            print("on main thread in callback() = \(Thread.isMainThread)")
            
            // pull all dog breed facts about each breed
            if let array = json {
                for object in array {
                    let d = object as! [String:Any]
                    let name = d["name"] as! String
                    let bred_for = d["bred_for"] ?? ""
                    let lifespan = d["life_span"] ?? ""
                    let temperament = d["temperament"] ?? ""
                    let weight = (d["weight"] as! [String:Any])["imperial"] ?? ""
                    let height = (d["height"] as! [String:Any])["imperial"] ?? ""
                    let breed = DogBreed(name:name, bredFor:bred_for as! String, lifespan:lifespan as! String, temperament:temperament as! String, weight:weight  as! String, height:height as! String)

                    //add to the table
                    self.dogBreeds.append(breed)
                }
            }
    
            //update table with concert data
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
            
        })
        
        //starts the download
        dataTask.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //  return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return dogBreeds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogBreedCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = dogBreeds[indexPath.row].getName()

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get the new view controller using segue.destination
        // pass the selected object to the new view controller
        
        //which row was selected?
        
        let indexPath = tableView.indexPathForSelectedRow

        let dogBreed = self.dogBreeds[indexPath!.row]
        
        // Create new ParkDetailTableViewController and set its properties
        let detailViewController = segue.destination as! BreedDetailTableVC
        detailViewController.title = dogBreed.getName()
        detailViewController.dogBreed = dogBreed
    }
}
