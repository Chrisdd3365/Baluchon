//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 21/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var myTextTextField: UITextField!
    @IBOutlet weak var myTranslatedTextLabel: UILabel!
    @IBOutlet weak var translationButton: UIButton!
    
    let translationService = TranslationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func translate() {
        if myTextTextField.text != "" {
            
            
            
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        myTextTextField.resignFirstResponder()
    }
    
//    func translation() {
//        translationService.getTranslation(text: "", source: "fr", target: "en") { (success, translation) in
//            if success, let translation = translation {
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//    }
    
    
    
    
}


