//
//  CurrencyChangeViewController.swift
//  Baluchon
//
//  Created by Christophe DURAND on 07/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class CurrencyChangeViewController: UIViewController {
    
    var currencyChangeService = CurrencyChangeService()
    var selectedCurrency: Double = 0
    
    @IBOutlet weak var myValueTextField: UITextField!
    @IBOutlet weak var myCurrencyTextField: UITextField!
    @IBOutlet weak var myConvertedValueLabel: UILabel!
    
    @IBAction func convert(_ sender: Any) {
        if myValueTextField.text != "" {
            myConvertedValueLabel.text = String(Double(myValueTextField.text!)! * selectedCurrency)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyChangeService.getCurrencyChange()
        createCurrencyPicker()
        createNumberPad()
        createToolBar()
    }
    
    func createCurrencyPicker() {
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        myCurrencyTextField.inputView = currencyPicker
    }
    
    func createNumberPad() {
        myValueTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CurrencyChangeViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        myValueTextField.inputAccessoryView = toolBar
        myCurrencyTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        selectedCurrency = currencyChangeService.values[row]
        myCurrencyTextField.text = currencyChangeService.currencies[row]
    }
}

extension CurrencyChangeViewController: CurrencyChangeDelegate {
    func alertShow(title: String, message: String) {
        updateShowAlert(title: title, message: message)
    }
}







