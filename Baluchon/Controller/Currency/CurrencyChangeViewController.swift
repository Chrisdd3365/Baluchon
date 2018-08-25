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
   
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        createCurrencyPicker()
        createNumberPad()
    }
    
    //MARK: - Action
    @IBAction func convert() {
        CurrencyChangeService.shared.getCurrencyChange { (success, rates) in
            if success, let rates = rates {
                self.update(currency: rates)
            } else {
                self.showAlert(title: "Error", message: "Rates download failed!")
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        myValueTextField.resignFirstResponder()
        myCurrencyTextField.resignFirstResponder()
    }
    
    //MARK: - Methods
    func update(currency: Currency) {
        if myValueTextField.text != "" {
            myConvertedValueLabel.text = String(Double(myValueTextField.text!)! * (currency.rates?.rate)!)
            myConvertedValueLabel.text = String(format: "%.2f")
        }
    }
    
    func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
    
    func createCurrencyPicker() {
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        myCurrencyTextField.inputView = currencyPicker
    }
    
    func createNumberPad() {
        myValueTextField.keyboardType = UIKeyboardType.numberPad
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
        return CurrencyChangeService.shared.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myCurrencyTextField.text = CurrencyChangeService.shared.currencies[row]
    }
}









