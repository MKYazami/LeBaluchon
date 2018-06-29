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

// MARK: 
extension TranslationViewController {
    
}
