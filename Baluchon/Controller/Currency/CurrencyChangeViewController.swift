//
//  CurrencyChangeViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 07/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var myValueTextField: UITextField!
    @IBOutlet weak var myCurrencyTextField: UITextField!
    @IBOutlet weak var myConvertedValueLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var selectedCurrency: Double = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myValueTextField.delegate = self
        myCurrencyTextField.delegate = self
        convertButton.isEnabled = false
        currencyChange()
        createCurrencyPicker()
        createNumberPad()
    }
    //MARK: - Action
    @IBAction func convert() {
        if myValueTextField.text != "" {
            let result = Double(myValueTextField.text!)! * selectedCurrency
            myConvertedValueLabel.text = String(format: "%.2f", result)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        myValueTextField.resignFirstResponder()
        myCurrencyTextField.resignFirstResponder()
    }
    
    //MARK: - Methods
    func currencyChange() {
        CurrencyChangeService.shared.getCurrencyChange { (success, rate) in
            self.toggleActivityIndicator(shown: true)
            if success {
                self.toggleActivityIndicator(shown: false)
            } else {
                self.showAlert(title: "Error", message: "Rates download failed!")
            }
        }
    }
    
    func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }

    func createNumberPad() {
        myValueTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    func createCurrencyPicker() {
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        myCurrencyTextField.inputView = currencyPicker
    }
}

extension CurrencyChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyChangeService.shared.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        CurrencyChangeService.shared.currencies.sort()
        return CurrencyChangeService.shared.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = CurrencyChangeService.shared.rate[row]
        myCurrencyTextField.text = CurrencyChangeService.shared.currencies[row]
    }
}

extension CurrencyChangeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if myValueTextField.hasText && myCurrencyTextField.hasText {
            convertButton.isEnabled = true
        } else {
            convertButton.isEnabled = false
        }
    }
}








