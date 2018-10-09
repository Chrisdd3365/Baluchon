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
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var convertedAmountLabel: UILabel!
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
        convertValue()
    }

    //MARK: - Methods
    //Method to get the converted value
    private func convertValue() {
        if amountTextField.text != "" {
            var total: Double = 0
            guard let amountTextField = amountTextField.text else { return }
            guard let result = Double(amountTextField) else { return }
            total = result * selectedCurrency
            convertedAmountLabel.text = String(format: "%.2f", total)
        }
    }
    //Method to call the getCurrencyChange method from CurrencyChangeService
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
    //Method to dismiss keyboard from UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //Method to toggle activity indicator when datas are currently downloading
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }
    //Method to activate the number pad when taping on the value text field
    private func createNumberPad() {
        amountTextField.keyboardType = UIKeyboardType.numberPad
    }
    //Method to create a picker view programmatically
    private func createCurrencyPicker() {
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        currencyPicker.backgroundColor = .white
        currencyTextField.inputView = currencyPicker
    }
    //Method to delegate from the UITextFieldDelegate
    private func textFieldDelegate() {
        amountTextField.delegate = self
        currencyTextField.delegate = self
        convertButton.isEnabled = false
    }
    //Method to clear the converted value label when the text fields are empties
    private func clearConvertedValueLabel() {
        if amountTextField.text == "" || currencyTextField.text == "" {
            convertedAmountLabel.text = nil
        }
    }
}
//Extension UIPickerViewDelegate
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
        currencyTextField.text = currencyChangeService.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 17)
        label.text = currencyChangeService.currencies[row]
        return label
    }
}
//Extension UITextFieldDelegate
extension CurrencyChangeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if amountTextField.hasText && currencyTextField.hasText {
            convertButton.isEnabled = true
        } else {
            convertButton.isEnabled = false
            clearConvertedValueLabel()
        }
    }
}
















