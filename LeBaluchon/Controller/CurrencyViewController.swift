//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Mehdi on 27/06/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var currencyResultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    
    // MARK: Action
    @IBAction func convert() {
        Helper.toogleActivityController(activityIndicator: activityIndicator, button: convertBtn, showActivityIndicator: true)
        getCalculatedCurrency()
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.toogleActivityController(activityIndicator: activityIndicator, button: convertBtn, showActivityIndicator: false)
    }
    
    /// Get data from the Model
    private func getCalculatedCurrency() {
        CurrencyService.sharedInstance.getCurrency { (success, currency) in
            Helper.toogleActivityController(activityIndicator: self.activityIndicator, button: self.convertBtn, showActivityIndicator: false)
            if success, let currency = currency {
                self.updateDisplay(currency: currency)
            } else {
                self.alertMessage(title: HelperData.httpErrorRequestAlertTitle, message: HelperData.httpErrorRequestAlertMessage)
            }
        }
    }
    
    /// Update diplay of some labels
    ///
    /// - Parameter currency: Currency get from the Model to update into the view
    private func updateDisplay(currency: Currency) {
        guard let inputCurrency = currencyTextField.text, !inputCurrency.isEmpty else {
            alertMessage(title: "Données manquantes", message: "Merci de bien vouloir entrer un nombre !")
            resetDisplay()
            return
        }
        
        guard let baseCurrencyRate = Double(inputCurrency) else {
            alertMessage(title: "Données Erronées", message: "Merci de bien vouloir entrer un nombre pour obtenir la devise !")
            resetDisplay()
            return
        }
        
        guard let rateTarget = currency.rates?.usd else {
            alertMessage(title: "Taux indisponible", message: "Le taux n'a pu être obtenu du serveur")
            return
        }
        
        let currencyResult = Currency.calculateCurrency(baseCurrency: baseCurrencyRate, rateTarget: rateTarget)

        currencyResultLabel.text = String(format: "%.3f", currencyResult)
        baseCurrencyLabel.text = currency.baseCurrency
        targetCurrencyLabel.text = "USD"
    }
    
    /// Reset views that needs a default view in certain situations
    private func resetDisplay() {
        currencyTextField.text = ""
        currencyResultLabel.text = ""
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

// MARK: Keyboard Behaviours
extension CurrencyViewController: UITextFieldDelegate {
    
    //Dismiss the keyboard when touching somewhere in the sreen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Set the keyboard return key in case changing the keyboard type
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        getCalculatedCurrency()
        return true
    }
    
}
