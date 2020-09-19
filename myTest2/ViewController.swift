//
//  ViewController.swift
//  myTest2
//
//  Created by Paul Ybarra on 8/7/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreFoundation

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var manager:CBCentralManager!
    var ledBT: CBPeripheral!
    var BTcharacteristics: [CBCharacteristic] = []
    var ledState: [UInt8] = [0]
    var ledCharacteristic: CBCharacteristic!
    var ledPeripheral:CBPeripheral!
    var ledPerpherals: [CBPeripheral] = []
    var pickData: [String] = []
    var pickSelected: String?
    var bleRow = 0
    var perphFound: [CBPeripheral] = []
    
    @IBOutlet weak var switchState: UISwitch!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    @IBAction func sliderState(_ sender: Any) {
        ledState[0] = UInt8(sliderValue.value)
        let data = NSData(bytes: ledState, length: ledState.count)
        ledPeripheral.writeValue(data as Data, for: ledCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
        //        ledPeripheral.readValue(for: ledCharacteristic)
        //        print(ledCharacteristic!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        createPicker()
        createToolbar()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scanStop), userInfo: nil, repeats: false)
    }
    
    @objc func scanStop() {
        manager.stopScan()
//        print(pickData)
    }
    
    func createPicker() {
        let pickerVw = UIPickerView()
        pickerVw.dataSource = self
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
        ledPeripheral = ledPerpherals[bleRow]
        ledPeripheral.delegate = self
        manager.connect(ledPeripheral)
        print(ledPerpherals)
        print(BTcharacteristics)
        view.endEditing(true)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if switchState.isOn {
            ledState[0] = 255
        }
        else { ledState[0] = 0}
        let data = NSData(bytes: ledState, length: ledState.count)
        ledPeripheral.writeValue(data as Data, for: ledCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
        //        ledPeripheral.readValue(for: ledCharacteristic)
        //        print(ledCharacteristic!)
        //        ledBT.discoverServices([ledBTservice])
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewAccessibilityDelegate  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bleRow = row
        textField.text = pickData[bleRow]
        print("Row = \(bleRow)")
    }
}

