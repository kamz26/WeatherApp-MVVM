//
//  SearchCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import UIKit

enum ListCategory:Int,CaseIterable{
    case recentSearch
    case fav
    
    var getTitle:String{
        switch self {
        case .recentSearch:
            return "Recent Search"
        case .fav:
            return "Favourite"
        }
    }
    
}

class SearchCityWeatherViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var citySearchResultTableView: UITableView!
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    var listVm:ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
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
        return ListCategory.allCases.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = ListCategory(rawValue: section)
        return category?.getTitle
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? listVm.citySearchResult.count :  listVm.favSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CitySearchResultTableViewCell.self, for: indexPath)
        let category = ListCategory(rawValue: indexPath.section)
        
        switch category {
        case .recentSearch:
            cell.configureCell(with: listVm.citySearchResult[indexPath.row])
            cell.addFavourite.addTapGestureRecognizer { [weak self] in
                self?.addToFav(index: indexPath.row)
            }
        case .fav:
            cell.configureCell(with: listVm.favSearchList[indexPath.row])
            cell.addFavourite.addTapGestureRecognizer { [weak self] in
                self?.removeFromFav(index: indexPath.row)
            }
        case .none:
            return UITableViewCell()
        }
        return cell
    }
    
    func removeFromFav(index:Int){
        listVm.removeFromFav(index: index) { [weak self] (error) in
            if error == nil{
                self?.citySearchResultTableView.reloadAsync()
            }
        }
    }
    
    func addToFav(index:Int){
        listVm.addToFav(index: index){ [weak self] error in
            if error == nil{
                self?.citySearchResultTableView.reloadAsync()
            }
        }
        
    }
}


extension SearchCityWeatherViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getCityData(cityName: searchBar.text ?? "")
    }
    
    func getCityData(cityName:String){
       listVm.getCityData(cityName: cityName) {[weak self] (error) in
            if error == nil{
                self?.citySearchBar.text = ""
                self?.citySearchResultTableView.reloadAsync()
            }
        }
        
    }
}
