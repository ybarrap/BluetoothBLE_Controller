//
//  CentralMgrManager.swift
//  myTest2
//
//  Created by Dad on 9/14/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

import Foundation
import CoreBluetooth

extension ViewController {
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
