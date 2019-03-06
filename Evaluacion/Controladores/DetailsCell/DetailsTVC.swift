//
//  DetailsTVC.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/6/19.
//

import UIKit

class DetailsTVC: UITableViewCell {

    //MARK:- UI Controls
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var petFriendlyImage: UIImageView!
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Methods
    func fillCell(_ place: Place) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        self.titleLabel.text = place.name
        self.distanceLabel.text = "\(formatter.string(for: place.distance/1000)!) kms"
        self.addressLabel.text = "\(place.addressLine1!)\n\(place.addressLine2!)"
        self.ratingControl.buttonMaker(rating: place.rating)
        self.petFriendlyImage.alpha = place.isPetFriendly ? 1 : 0
    }

}
