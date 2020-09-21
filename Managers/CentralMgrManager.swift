//
//  CentralMgrManager.swift
//  myTest2
//
//  Created by Paul Ybarra on 9/14/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

//import Foundation
import UIKit
import CoreBluetooth
import CoreFoundation

extension ViewController {
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        //        perphFound.append(peripheral)
        if peripheral.name != nil {
            ledPerpherals.append(peripheral)
            pickData.append(String(peripheral.name!))
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected")
        peripheral.discoverServices([])
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleMsg = ""
        switch (central.state) {
        case .poweredOff:
            consoleMsg = "BLE is powered off"
        case .poweredOn:
            consoleMsg = "Ble is powered on"
            manager.scanForPeripherals(withServices: nil,options:nil)
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scanStop), userInfo: nil, repeats: false)
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
    
    @objc func scanStop() {
        manager.stopScan()
//        print(pickData)
        print("Scan stopped")
        textField.isEnabled = true
        textField.text = "Select BLE"
    }
}
