//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet weak var translationTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Dismiss the keyboard when touching somewhere in the sreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// MARK: Picker View
extension TranslationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    //Set number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set number of row in the component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageTranslationPair.count
    }
    
    //Display the titles of component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageTranslationPair[row]
    }
}
