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
    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBOutlet weak var languageTranslationPairPickerView: UIPickerView!
    @IBOutlet weak var translateBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Action
    @IBAction func translate() {
        toogleActivityIndicator(shown: true)
        getTranslatedText()
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        toogleActivityIndicator(shown: false)
    }
    
    private func getTranslatedText() {
        guard let textTotranslate = translationTextView.text, !textTotranslate.isEmpty else {
            alertMessage(title: "Champs Vide !", message: "Merci d'entrer du text à traduire")
            self.toogleActivityIndicator(shown: false)
            return
        }
        TranslationService.sharedInstance.getTranslation(textTotranslate: textTotranslate, languageTranslationPair: getLanguagePair()) { (success, translatedText) in
            self.toogleActivityIndicator(shown: false)
            if success, let translatedText = translatedText?.translatedText {
                self.updateDisplay(textTranslated: translatedText)
            } else {
                self.alertMessage(title: "Erreur Réseau", message: "Merci de vérifier votre connexion internet ou réessayer ultérieurement !")
            }
            
        }
    }
    
    private func updateDisplay(textTranslated: String) {
        translatedTextLabel.text = textTranslated
    }
    
    private func getLanguagePair() -> String {
        let languagePairIndex = languageTranslationPairPickerView.selectedRow(inComponent: 0)
        
        return languageTranslationPair[languagePairIndex]
    }
    
    private func toogleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        translateBtn.isHidden = shown
    }
    
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
    //Dismiss the keyboard when touching somewhere in the sreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
