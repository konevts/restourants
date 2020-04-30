//
//  MainViewController.swift
//  outAndAction
//
//  Created by Костя on 18.04.2020.
//  Copyright © 2020 Konstantin Evstafev. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var reversedSortedButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
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
    var places: Results<Place>!
    var ascSorting = true
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date")
        }
        else {
            places = places.sorted(byKeyPath: "name")
    }
        tableView.reloadData()
    }
    
    @IBAction func revesedSorting(_ sender: Any) {
        ascSorting.toggle()
        sorting()
        if ascSorting {
            reversedSortedButton.image = #imageLiteral(resourceName: "AZ")
        }
        else{
            reversedSortedButton.image = #imageLiteral(resourceName: "ZA")
        }
        tableView.reloadData()
    }
    
    private func sorting(){
        if(segmentedControl.selectedSegmentIndex == 0){
            places = places.sorted(byKeyPath: "date", ascending: ascSorting)
        }
        else{
            places = places.sorted(byKeyPath: "name", ascending: ascSorting)
        }
    }
    func timesTen(_ x:String) {
        let place = Place.init(name: x ,
                     location: "String",
                     type: "String",
                     imageData: UIImage(named: x)!.pngData()
            )
        Repository.saveObject(place)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        restourantNames.forEach(timesTen(_:))
        places = Repository.getAll()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let placeForCell = places[indexPath.row]
        
    
        cell.nameLabel?.text = placeForCell.name
     
        cell.imageOfPlace.image = UIImage(data: placeForCell.imageData!)
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        
        cell.locationLabel.text = placeForCell.location
        cell.typeLabel.text = placeForCell.type
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    //MARK: Table view deligate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
            //Code I want to do here
            let place = self.places[indexPath.row]
             Repository.deleteObject(place)
            tableView.reloadData()

        }
  
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = places[indexPath.row]
            
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
        
        }
    }
    

    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        newPlaceVC.savePlace()
        tableView.reloadData()
        
    }
}
