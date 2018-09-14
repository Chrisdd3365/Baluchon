//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 21/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var myTextTextField: UITextField!
    @IBOutlet weak var myTranslatedTextLabel: UILabel!
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    let translationService = TranslationService()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
    }
    
    //MARK: - Action
    @IBAction func translate() {
        translation()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        myTextTextField.resignFirstResponder()
    }
    
    //MARK: - Methods
    private func translation() {
        let source = SourceAndTarget.source
        let target = SourceAndTarget.target
        
        if myTextTextField.text != "" {
            translationService.getTranslation(text: myTextTextField.text!, source: source, target: target) { (success, translation) in
                self.toggleActivityIndicator(shown: true)
                if success, let translation = translation?.data.translations {
                    self.toggleActivityIndicator(shown: false)
                    let textTranslated = translation[0].translatedText
                    self.myTranslatedTextLabel.text = textTranslated
                } else {
                    self.showAlert(title: "Error", message: "Translation's data download failed!")
                }
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        translationButton.isHidden = shown
    }
    
    private func textFieldDelegate() {
        myTextTextField.delegate = self
        translationButton.isEnabled = false
    }
    
    private func clearTranslatedTextLabel() {
        if myTextTextField.text == ""  {
            myTranslatedTextLabel.text = nil
        }
    }
}

extension TranslationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if myTextTextField.hasText {
            translationButton.isEnabled = true
        } else {
            translationButton.isEnabled = false
            clearTranslatedTextLabel()
        }
    }
}

