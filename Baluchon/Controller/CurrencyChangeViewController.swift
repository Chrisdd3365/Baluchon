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
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    @IBAction func convert(_ sender: Any) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The conversion failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension CurrencyChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyChangeService.myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyChangeService.myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyChangeService.myValues[row]
    }
}










