//
//  MainViewController.swift
//  outAndAction
//
//  Created by Костя on 18.04.2020.
//  Copyright © 2020 Konstantin Evstafev. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let restourantNames = [
        "Mcdonalds",
        "KFC",
        "Burger King",
        "Subway",
        "Carls Jr.",
        "Крошка Картошка",
        "Hesburger",
        "Теремок",
        "Додо пицца"
    ]
    lazy var places: [Place] = restourantNames.map(timesTen)

    func timesTen(_ x:String) -> Place {
        return Place(name: x , location: "String", type: "String", image: x)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let placeForCell = places[indexPath.row]
        cell.nameLabel?.text = placeForCell.name
        cell.imageOfPlace?.image = UIImage(named: placeForCell.image)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        
        cell.locationLabel.text = placeForCell.location
        cell.typeLabel.text = placeForCell.type
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue){
        
    }
}
