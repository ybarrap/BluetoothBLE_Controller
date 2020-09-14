//
//  ViewController.swift
//  myTest2
//
//  Created by Paul Ybarra on 8/7/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var manager:CBCentralManager!
    var ledBT: CBPeripheral!
    let ledBTservice = CBUUID(string: "FFE0")
    let ledBTcharacteristic = CBUUID(string: "FFE1")
    var bytes : [String] = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if bytes[0] == "0" {
            bytes[0] = "1"
        }
        else { bytes[0] = "0"}
        ledBT.discoverServices([ledBTservice])
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        if peripheral.name == "BT05"{
            ledBT = peripheral
            ledBT.delegate = self
            manager.stopScan()
            manager.connect(ledBT)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected")
        ledBT.discoverServices([ledBTservice])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
//        let bytes : [String] = ["0"]
//        let data: NSData = "1".data(using: String.Encoding.utf8)! as NSData
        let data = NSData(bytes: bytes, length: bytes.count)
        for characteristic in characteristics {
            print(characteristic)
            peripheral.writeValue(data as Data, for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
            peripheral.readValue(for: characteristic)
            print(characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic.value ?? "no value")
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleMsg = ""
        switch (central.state) {
        case .poweredOff:
            consoleMsg = "BLE is powered off"
        case .poweredOn:
            consoleMsg = "Ble is powered on"
            manager.scanForPeripherals(withServices: nil,options:nil)
        case .resetting:
            consoleMsg = "BLE is resetting"
        case .unauthorized:
            consoleMsg = "BLE is unauthorized"
        case .unknown:
            consoleMsg = "BLE is unknown"
        case .unsupported:
            consoleMsg = "BLE is powered off"
        @unknown default:
            consoleMsg = "BLE Fatal Error"
        }
        print(consoleMsg)
    }

}
