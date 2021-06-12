//
//  UITableView+Extensions.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation
import UIKit

//MARK:- UITableView
extension UITableView {
     func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: T.self)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
 
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func reloadAsync() {
        DispatchQueue.main.async {
             self.reloadData()
        }
    }
}
