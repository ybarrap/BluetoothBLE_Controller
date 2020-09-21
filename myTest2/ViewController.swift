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
    var bleRow: Int = -1
    var perphFound: [CBPeripheral] = []
    
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sliderValue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        createPicker()
        createToolbar()
        textField.textColor = .systemRed
        textField.backgroundColor = .black
        //        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scanStop), userInfo: nil, repeats: false)
    }
    
    
    @IBAction func sliderState(_ sender: Any) {
        ledState[0] = UInt8(sliderValue.value)
        let data = NSData(bytes: ledState, length: ledState.count)
        if bleRow != -1 {
            ledPeripheral.writeValue(data as Data, for: ledCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
            if textField.isEnabled {textField.text = "\(Int(sliderValue.value))"
            }
        }
        //        ledPeripheral.readValue(for: ledCharacteristic)
        //        print(ledCharacteristic!)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if switchState.isOn {
            ledState[0] = 255
        }
        else { ledState[0] = 0}
        let data = NSData(bytes: ledState, length: ledState.count)
        if bleRow != -1 {
            ledPeripheral.writeValue(data as Data, for: ledCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
            if textField.isEnabled {
                if switchState.isOn
                {textField.text = "LED On"}
                else { textField.text = "LED Off"}
            }
        }
        //        ledPeripheral.readValue(for: ledCharacteristic)
        //        print(ledCharacteristic!)
        //        ledBT.discoverServices([ledBTservice])
    }
}



