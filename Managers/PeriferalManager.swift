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
}
