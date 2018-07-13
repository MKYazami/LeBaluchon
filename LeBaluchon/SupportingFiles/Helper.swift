//
//  Helper.swift
//  LeBaluchon
//
//  Created by Mehdi on 06/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import UIKit

/// Contains useful general methods to the project
class Helper {
    
    /// Allows to toogle activity indicator with button, when true the method hide button and show acticity indicator
    ///
    /// - Parameters:
    ///   - activityIndicator: Acticity indicator to show/hide
    ///   - button: Button to show/hide
    ///   - showActivityIndicator: true hide button and show activity indicator / false show button and hide activity indicator
    static func toogleActivityController(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool) {
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
    }
}
