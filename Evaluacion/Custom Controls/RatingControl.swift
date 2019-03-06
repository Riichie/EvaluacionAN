//
//  RatingControl.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/5/19.
//

import UIKit

class RatingControl: UIStackView {
    
    //MARK:- Variables
    var ratingButtons = [UIButton]()
    var rating = 0

    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonMaker(rating: 0)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        buttonMaker(rating: 0)
    }
    
    //MARK:- Methods
    func buttonMaker(rating: Double) {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let filledStar = UIImage(named: "star")
        let emptyStar = UIImage(named:"star_border")
        let halfStar = UIImage(named:"star_half")
        
        let filledStars = floor(rating)
        var halfMarked = false
        for stars in 0 ..< 5 {
            let button = UIButton()
            button.tintColor = UIColor.red
            if stars < Int(filledStars){
                button.setImage(filledStar, for: .normal)
            } else {
                if rating.truncatingRemainder(dividingBy: 1) != 0 && !halfMarked {
                    button.setImage(halfStar, for: .normal)
                    halfMarked = true
                } else {
                    button.setImage(emptyStar, for: .normal)
                }
            }
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
