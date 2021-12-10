//
//  Utilities.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation
import UIKit

class Utilities {
  
  class func setAlert(sms: String) -> UIAlertController {
    let alert = UIAlertController(title: "WARNING", message: sms, preferredStyle: UIAlertController.Style.alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.setValue(NSAttributedString(string: "WARNING", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]), forKey: "attributedTitle")
    alert.setValue(NSAttributedString(string: sms, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 15)!]), forKey: "attributedMessage")
    
    let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
    subview.backgroundColor = UIColor.white
    alert.view.tintColor = UIColor.black
    alert.addAction(ok)
    return alert
  }

}
