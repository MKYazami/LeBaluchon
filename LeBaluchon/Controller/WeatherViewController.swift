//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var newyorkTemperatureLabel: UILabel!
    @IBOutlet weak var parisTemperatureLabel: UILabel!
    
    @IBOutlet weak var newyorkWeatherConditionsIcon: UIImageView!
    @IBOutlet weak var parisWeatherConditionsIcon: UIImageView!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}
