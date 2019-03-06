//
//  PlaceTVC.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/5/19.
//

import UIKit

class PlaceTVC: UITableViewCell {

    //MARK:- UI Controls
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var petFriendlyImage: UIImageView!
    @IBOutlet weak var imagePlace: UIImageView!
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Methods
    func fillCell(_ place: Place){
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        self.titleLabel.text = place.name
        self.detailLabel.text = place.address
        self.distanceLabel.text = "\(formatter.string(for: place.distance/1000)!) kms"
        self.petFriendlyImage.alpha = place.isPetFriendly ? 1 : 0
        self.ratingControl.buttonMaker(rating: place.rating)
        
        let url = URL(string: place.thumbnail)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {    // execute on main thread
                self.imagePlace.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
}
