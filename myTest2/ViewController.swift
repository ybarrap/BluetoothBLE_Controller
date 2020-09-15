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
    
    @IBOutlet weak var switchState: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if switchState.isOn {
            bytes[0] = "1"
        }
        else { bytes[0] = "0"}
        ledBT.discoverServices([ledBTservice])
    }
}




