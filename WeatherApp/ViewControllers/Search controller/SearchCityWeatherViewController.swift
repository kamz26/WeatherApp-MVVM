//
//  SearchCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import UIKit

class SearchCityWeatherViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var citySearchResultTableView: UITableView!
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    var listVm:ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listVm = ListViewModel()
        self.listVm.updateLocalFetch()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func viewSetup(){
        citySearchBar.delegate = self
        tableViewSetup()
    }
    
    fileprivate func tableViewSetup(){
       citySearchResultTableView.register(cellType: CitySearchResultTableViewCell.self)
        
        citySearchResultTableView.delegate = self
        citySearchResultTableView.dataSource = self
    }
}
//MARK: - Delegate and Datasource
extension SearchCityWeatherViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "Favourite"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? listVm.citySearchResult.count :  listVm.favSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CitySearchResultTableViewCell.self, for: indexPath)
        
        if indexPath.section == 0{
        cell.configureCell(with: listVm.citySearchResult[indexPath.row])
        cell.addFavourite.addTapGestureRecognizer {
            self.addToFav(index: indexPath.row)
        }
        }else{
            cell.configureCell(with: listVm.favSearchList[indexPath.row])
        }
        return cell
    }
    
    func addToFav(index:Int){
        listVm.addToFav(index: index){ error in
            if error == nil{
                DispatchQueue.main.async {
                    self.citySearchResultTableView.reloadAsync()
                }
                
            }
        }
        
    }
}


extension SearchCityWeatherViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getCityData(cityName: searchBar.text ?? "")
    }
    
    func getCityData(cityName:String){
       listVm.getCityData(cityName: cityName) { (error) in
            if error == nil{
                self.citySearchBar.text = ""
                self.citySearchResultTableView.reloadAsync()
            }
        }
        
    }
}
