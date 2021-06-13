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
    @IBOutlet weak var addFavourite: UIImageView!
    
    var normalImage: UIImage = UIImage.init(named: "heart")!
    var favImage: UIImage = UIImage.init(named: "heart_filled")!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with city: CitySearchViewModel?){
        guard let city = city else {return}
        
        cityName.text = city.name
        
        minimumTemperatureLabel.text = city.minTemp
        maximumTemperatureLabel.text = city.maxTemp
        
        sunriseTempLabel.text = city.sunrise
        sunsetTempLabel.text = city.sunset
        
        addFavourite.image = city.isFAv ? favImage : normalImage
    }
    
}
