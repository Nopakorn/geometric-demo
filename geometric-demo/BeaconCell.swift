//
//  BeaconCell.swift
//  geometric-demo
//
//  Created by Siam System Deverlopment on 20/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//


import UIKit

class BeaconCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metersLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var proximityLabel: UILabel!
    
    func setName(_ name: String) {
        nameLabel.text = name
    }
    
    func setRssi(_ rssi: String) {
        rssiLabel.text = rssi
    }
    
    func setMeters(_ meters: String) {
        metersLabel.text = meters
    }
    
    func setProximity(_ proximity: String) {
        proximityLabel.text = proximity
    }
}
