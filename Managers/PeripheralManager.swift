//
//  Periferals.swift
//  myTest2
//
//  Created by Dad on 9/14/20.
//  Copyright © 2020 org.ybarrap. All rights reserved.
//

import Foundation
import CoreBluetooth

extension ViewController {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        var tmpStr: String = ""
        let regex = try!  NSRegularExpression(pattern: "[0-9A-F]{4}")
        for service in services {
            tmpStr = "\(service.uuid)"
            let range = NSRange(location: 0, length: tmpStr.utf8.count)
            if  regex.firstMatch(in: tmpStr, options: [], range: range) != nil{
                peripheral.discoverCharacteristics(nil, for: service)
                print("Service = \(tmpStr)")
                break
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
         let regex = try!  NSRegularExpression(pattern: "[0-9A-F]{4}")
        var tmpStr: String = ""
        for characteristic in characteristics {
            ledCharacteristic = characteristic
            tmpStr = "\(ledCharacteristic.uuid)"
            let range = NSRange(location: 0, length: tmpStr.utf8.count)
            if  regex.firstMatch(in: tmpStr, options: [], range: range) != nil{
                //                print(ledCharacteristic ?? "No characteristic")
                print("Characteristic = \(String(describing: ledCharacteristic.uuid))")
                break
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(" Char val: \(String(describing: characteristic.value))" )
    }
}
