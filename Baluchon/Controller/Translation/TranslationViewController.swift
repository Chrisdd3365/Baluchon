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
    @IBOutlet weak var textToTranslateTextField: UITextField!
    @IBOutlet weak var textTranslatedTextView: UITextView!
    @IBOutlet weak var translationButton: UIButton!
    
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
    
    //MARK: - Methods
    private func translation() {
        guard let textTextField = textToTranslateTextField.text else { return }
        translationService.getTranslation(text: textTextField) { (success, translation) in
            if success, let translation = translation?.data.translations {
                let textTranslated = translation[0].translatedText
                self.textTranslatedTextView.text = textTranslated
            } else {
                self.showAlert(title: "Error", message: "Translation's data download failed!")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func textFieldDelegate() {
        textToTranslateTextField.delegate = self
        translationButton.isEnabled = false
    }
    
    private func clearTranslatedTextLabel() {
        if textToTranslateTextField.text == ""  {
            textTranslatedTextView.text = nil
        }
    }
}

extension TranslationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textToTranslateTextField.hasText {
            translationButton.isEnabled = true
        } else {
            translationButton.isEnabled = false
            clearTranslatedTextLabel()
        }
    }
}

