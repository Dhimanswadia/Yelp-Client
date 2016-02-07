//
//  BussinessCell.swift
//  Yelp
//
//  Created by Dhiman on 2/2/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BussinessCell: UITableViewCell {

    @IBOutlet weak var THUMB: UIImageView!
    @IBOutlet weak var RATINGS: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var CATEGORYname: UILabel!
    @IBOutlet weak var REviewsName: UILabel!
    @IBOutlet weak var distancename: UILabel!
    @IBOutlet weak var SWEGname: UILabel!
    
    var business : Business! {
        didSet {
            hotelName.text = business.name
            if let imgURL = business.imageURL {
                THUMB.setImageWithURL(imgURL)
            }
            CATEGORYname.text = business.categories
            addressName.text = business.address
            REviewsName.text = "\(business.reviewCount!)Reviews"
            RATINGS.setImageWithURL(business.ratingImageURL!)
            distancename.text = business.distance
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        THUMB.layer.cornerRadius = 4
        THUMB.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
