//
//  SearchCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import UIKit

class SearchCityWeatherViewController: UIViewController {
    
    var listVm:ListViewModel
    
    init?(coder: NSCoder, vm:ListViewModel) {
        self.listVm = ListViewModel()
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a List View Model")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
