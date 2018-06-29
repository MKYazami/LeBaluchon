//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    @IBOutlet weak var currencyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Dismiss the keyboard when touching somewhere in the sreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: Keyboard return key
extension CurrencyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
//        Add method to convert currency
        return true
    }
    
}
