//
//  ViewController.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/5/19.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    //MARK:- UI Controls
    @IBOutlet weak var placesTableView: UITableView!
    
    //MARK:- Variables
    var arrayPlaces: [Place] = []
    let locationManager = CLLocationManager()
    var placeSelected: Place?
    let segueName = "showDetail"
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let url = URL(string: "http://www.mocky.io/v2/5bf3ce193100008900619966")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonArray = json as? [[String: Any]] else {
                return
            }
    
            for place in jsonArray {
                self.arrayPlaces.append(Place.initPlace(place))
            }
            
            DispatchQueue.main.async {
                self.placesTableView.reloadData()
            }
        }
        task.resume()
    }
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell") as! PlaceTVC
        cell.fillCell(self.arrayPlaces[indexPath.row])
        
        return cell
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeSelected = self.arrayPlaces[indexPath.row]
        self.performSegue(withIdentifier: self.segueName, sender: nil)
    }
    
    //MARK:- CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        self.longitude = coordinates.longitude
        self.latitude = coordinates.latitude
        
        if arrayPlaces.count > 0 {
            for place in arrayPlaces {
                let myLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
                
                place.distance = myLocation.distance(from: placeLocation)
                
            }
        }
        
        self.arrayPlaces = arrayPlaces.sorted(by: {$0.distance < $1.distance})
        
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueName {
            
            let detailController = segue.destination as! DetailViewController
            
            detailController.placeSelected = self.placeSelected
            detailController.longitude = self.longitude
            detailController.latitude = self.latitude
        }
    }

}
