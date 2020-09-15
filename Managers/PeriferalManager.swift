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
        ledPeripheral = peripheral
        for characteristic in characteristics {
            ledCharacteristic = characteristic
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(" Char val: \(String(describing: characteristic.value))" )
        
    }
}
