//
//  PickerManager.swift
//  BLELEDController
//
//  Created by Paul Ybarra on 9/20/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

//import Foundation
import UIKit

extension ViewController: UIPickerViewDataSource, UIPickerViewAccessibilityDelegate  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        print("Row = \(bleRow)")
        return pickData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bleRow = row
        textField.text = pickData[bleRow]
        print("Row = \(bleRow)")
    }
    
    func createPicker() {
        let pickerVw = UIPickerView()
        //        pickerVw.dataSource = self
        pickerVw.delegate = self
        textField.inputView = pickerVw
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissKeyboard() {
        
        if bleRow == -1 { bleRow = 0}
        ledPeripheral = ledPerpherals[bleRow]
        ledPeripheral.delegate = self
        manager.connect(ledPeripheral)
        //        print(ledPerpherals)
        view.endEditing(true)
        textField.text = pickData[bleRow]
        
    }
    
}
