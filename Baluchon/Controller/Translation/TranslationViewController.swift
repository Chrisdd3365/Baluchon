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
        setupBehavior()
        setPlaceholderTextView()
    }
    
    //MARK: - Action
    @IBAction func translate() {
        translation()
    }
    
    //MARK: - Methods
    //Method to call the getTranslation method from TranslationService
    private func translation() {
        guard let textTextField = textToTranslateTextField.text else { return }
        translationService.getTranslation(text: textTextField) { (success, translation) in
            if success, let translation = translation?.data.translations {
                let textTranslated = translation[0].translatedText
                self.textTranslatedTextView.text = textTranslated
                self.textTranslatedTextView.textColor = UIColor.black
            } else {
                self.showAlert(title: "Error", message: "Translation's data download failed!")
            }
        }
    }
    //Method to handle setup behavior of textToTranslateTextField
    private func setupBehavior() {
        textToTranslateTextField.addTarget(self, action: #selector(textToTranslateTextFieldDidChange), for: .editingChanged)
    }
    //Method to handle isEnabled property of translationButton when textToTranslateTextField is empty
    @objc func textToTranslateTextFieldDidChange() {
        guard let text = textToTranslateTextField.text, !text.isEmpty else {
            translationButton.isEnabled = false
            setPlaceholderTextView()
            return
        }
        translationButton.isEnabled = true
    }
    //Method to dismiss keyboard from UITextView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //Method to set placeholder into the text view
    private func setPlaceholderTextView() {
        textTranslatedTextView.text = "To: English"
        textTranslatedTextView.textColor = UIColor.lightGray
    }
}







