//
//  DetailsActionsTVC.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/6/19.
//

import UIKit

class DetailsActionsTVC: UITableViewCell {

    //MARK:- UI Controls
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
