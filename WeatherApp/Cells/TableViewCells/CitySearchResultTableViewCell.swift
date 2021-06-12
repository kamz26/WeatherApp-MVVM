//
//  CitySearchResultTableViewCell.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import UIKit

class CitySearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var sunriseTempLabel: UILabel!
    @IBOutlet weak var sunsetTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with city: CitySearchResultModel?){
        guard city != nil else {return}
        cityName.text = city?.name ?? ""
    }
    
}
