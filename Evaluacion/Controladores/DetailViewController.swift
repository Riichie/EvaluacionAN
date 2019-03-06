//
//  DetailViewController.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/5/19.
//

import UIKit
import GoogleMaps

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- UI Controls
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    //MARK:- Variables
    var placeSelected: Place!
    var longitude: Double!
    var latitude: Double!
    var zoomLevel: Float = 14.0
    let segueName = "showWeb"
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: placeSelected.latitude, longitude: placeSelected.longitude, zoom: zoomLevel)
        self.mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: placeSelected.latitude, longitude: placeSelected.longitude)
        marker.title = placeSelected.name
        marker.snippet = placeSelected.address
        marker.map = mapView

    }
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cellDetails") as! DetailsTVC
            cell.fillCell(self.placeSelected)
            
            return cell
            
        case 1:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cellActions") as! DetailsActionsTVC
            cell.actionTitleLabel.text = "Directions"
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .abbreviated
            
            let formattedString = formatter.string(from: TimeInterval(placeSelected.distance/120))!
            cell.descriptionLabel.text = "\(formattedString) drive"
            cell.cellImageView.image = UIImage(named: "directions")
            return cell
            
        case 2:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cellActions") as! DetailsActionsTVC
            cell.actionTitleLabel.text = "Call"
            cell.descriptionLabel.text = placeSelected.phoneNumber
            cell.cellImageView.image = UIImage(named: "call")
            return cell
        
        case 3:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cellActions") as! DetailsActionsTVC
            cell.actionTitleLabel.text = "Visit Website"
            cell.descriptionLabel.text = placeSelected.site
            cell.cellImageView.image = UIImage(named: "link")
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(self.placeSelected.latitude!),\(self.placeSelected.longitude!)directionsmode=driving")!, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://");
                print("comgooglemaps://?saddr=&daddr=\(self.placeSelected.latitude!),\(self.placeSelected.longitude!)directionsmode=driving")
            }
            
        case 2:
            if (UIApplication.shared.canOpenURL(URL(string: "tel://")!)) {
                UIApplication.shared.open(URL(string: "tel://\(self.placeSelected.phoneNumber!)")!, options: [:], completionHandler: nil)
            }
            
        case 3:
            self.performSegue(withIdentifier: self.segueName, sender: nil)
            
        default:
            print("Error")
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueName {
            let webViewController = segue.destination as! WebViewController
            webViewController.url = self.placeSelected.site
        }
    }
}
