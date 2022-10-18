//
//  DataCell.swift
//  WeatherFinal
//
//  Created by minhdat on 18/10/2022.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
