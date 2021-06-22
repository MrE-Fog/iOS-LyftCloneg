//
//  RideQuoteCell.swift
//  LyftClone
//
//  Created by Weerawut Chaiyasomboon on 12/6/2564 BE.
//

import UIKit

class RideQuoteCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func update(rideQuote: RideQuote){
        thumbnailImageView.image = UIImage(named: rideQuote.thumbnail)
        titleLabel.text = rideQuote.name
        capacityLabel.text = rideQuote.capacity
        priceLabel.text = String(format: "$%.2f", rideQuote.price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        timeLabel.text = dateFormatter.string(from: rideQuote.time)
        
    }
    
    func updateSelectStatus(status: Bool){
        if status{
            contentView.layer.cornerRadius = 5.0
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = UIColor(red: 149.0/255.0, green: 67.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
        }else{
            contentView.layer.borderWidth = 0.0
        }
    }
}
