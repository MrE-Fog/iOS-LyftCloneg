//
//  LocationViewController.swift
//  LyftClone
//
//  Created by Weerawut Chaiyasomboon on 10/6/2564 BE.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKLocalSearchCompleterDelegate {

    var locations = [Location]()
    var pickupLocation: Location?
    var dropoffLocation: Location?
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dropoffTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locations = LocationService.shared.getRecentLocations()
        
        dropoffTextField.becomeFirstResponder()
        dropoffTextField.delegate = self
        
        searchCompleter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func cancelDidTap(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let routeVC = segue.destination as? RouteViewController, let dropoffLocation = sender as? Location{
            routeVC.pickupLocation = pickupLocation
            routeVC.dropoffLocation = dropoffLocation
        }
    }
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? locations.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        if searchResults.isEmpty{
            cell.update(location: locations[indexPath.row])
        }else{
            let searchResult = searchResults[indexPath.row]
            cell.update(searchResult: searchResult)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults.isEmpty{
            let location = locations[indexPath.row]
            performSegue(withIdentifier: "LocationToRoute", sender: location)
        }else{
            let searchResult = searchResults[indexPath.row]
            let searchRequest = MKLocalSearch.Request(completion: searchResult)
            let search = MKLocalSearch(request: searchRequest)
            search.start(completionHandler: { (response,error) in
                if error == nil{
                    if let dropoffPlaceMark = response?.mapItems.first?.placemark{
                        let location = Location(placemark: dropoffPlaceMark)
                        self.performSegue(withIdentifier: "LocationToRoute", sender: location)
                    }
                }
            })
        }
    }

    //MARK: TextField
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let latestString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print("Latest String: \(latestString)")
        
        if latestString.count > 3{
            searchCompleter.queryFragment = latestString
        }
        
        return true
    }
    
    //MARK: MKLocalSearchCompleterDelegate
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
        //reload tableView
        tableView.reloadData()
    }
}
