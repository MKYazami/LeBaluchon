//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    // MARK: Outltes
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var languageTranslationPairPickerView: UIPickerView!
    @IBOutlet weak var translateBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    /// This array allow to display the pair language in the UIPickerView and determine which one is used
    let languageTranslationPair = [
        "Français -> Anglais",
        "Anglais -> Français"
    ]
    
    // MARK: Action
    @IBAction func translate() {
        Helper.toogleActivityController(activityIndicator: activityIndicator, button: translateBtn, showActivityIndicator: true)
        getTranslatedText()
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.toogleActivityController(activityIndicator: activityIndicator, button: translateBtn, showActivityIndicator: false)
    }
    
    /// Get API data from Model
    private func getTranslatedText() {
        guard let textTotranslate = translationTextView.text, !textTotranslate.isEmpty else {
            alertMessage(title: "Champs Vide !", message: "Merci d'entrer du text à traduire")
            Helper.toogleActivityController(activityIndicator: activityIndicator, button: translateBtn, showActivityIndicator: false)
            return
        }
        TranslationService.sharedInstance.getTranslation(textTotranslate: textTotranslate, languageTranslationPair: getLanguagePair()) { (success, translatedText) in
            Helper.toogleActivityController(activityIndicator: self.activityIndicator, button: self.translateBtn, showActivityIndicator: false)
            if success, let translatedText = translatedText?.translatedText {
                self.updateDisplay(textTranslated: translatedText)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertMessage)
            }
            
        }
    }
    
    /// Update display
    ///
    /// - Parameter textTranslated: Text translated get from the Model to update into the view
    private func updateDisplay(textTranslated: String) {
        translatedTextView.text = textTranslated
    }
    
    /// Get the language which must determine the translation source and target
    ///
    /// - Returns: Language pair translation
    private func getLanguagePair() -> String {
        let languagePairIndex = languageTranslationPairPickerView.selectedRow(inComponent: 0)
        
        return languageTranslationPair[languagePairIndex]
    }
    
    /// Display pop up to warn the user
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Message title
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)
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

// MARK: Keyboard behaviours
extension TranslationViewController: UITextFieldDelegate {
    // Dismiss the keyboard when touching somewhere in the sreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Set the keyboard return key in case changing the keyboard type
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
