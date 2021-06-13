//
//  UIViewController+Extensions.swift
//  WeatherApp
//
//  Created by Abhisek K. on 11/06/21.
//

import Foundation
import UIKit

//MARK:- UIViewController
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Type casting done using Self(upper case)
    static func initFromNib() -> Self {
        
        func instanceFromNib<T: UIViewController>() -> T {
            
            //This assumes we are passing viewcontroller name as the nibname
            return T(nibName: String(describing: self), bundle: nil)
        }
        
        return instanceFromNib()
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
