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
    private var selectedCurrency: Double = 0
    let currencyChangeService = CurrencyChangeService()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
        currencyChange()
        createCurrencyPicker()
        createNumberPad()
    }
    //MARK: - Action
    @IBAction func convert() {
        if myValueTextField.text != "" {
            var total: Double = 0
            guard let valueTextField = myValueTextField.text else { return }
            guard let result = Double(valueTextField) else { return }
            total = result * selectedCurrency
            myConvertedValueLabel.text = String(format: "%.2f", total)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        myValueTextField.resignFirstResponder()
        myCurrencyTextField.resignFirstResponder()
    }
    
    //MARK: - Methods
    private func currencyChange() {
        currencyChangeService.getCurrencyChange { (success, rate) in
            self.toggleActivityIndicator(shown: true)
            if success {
                self.toggleActivityIndicator(shown: false)
            } else {
                self.showAlert(title: "Error", message: "Rates data download failed!")
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
    
    private func createNumberPad() {
        myValueTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    private func createCurrencyPicker() {
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        myCurrencyTextField.inputView = currencyPicker
    }
    
    private func textFieldDelegate() {
        myValueTextField.delegate = self
        myCurrencyTextField.delegate = self
        convertButton.isEnabled = false
    }
    
    private func clearConvertedValueLabel() {
        if myValueTextField.text == "" || myCurrencyTextField.text == "" {
            myConvertedValueLabel.text = nil
        }
    }
}

extension CurrencyChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyChangeService.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyChangeService.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyChangeService.rate[row]
        myCurrencyTextField.text = currencyChangeService.currencies[row]
    }
}

extension CurrencyChangeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if myValueTextField.hasText && myCurrencyTextField.hasText {
            convertButton.isEnabled = true
        } else {
            convertButton.isEnabled = false
            clearConvertedValueLabel()
        }
    }
}








