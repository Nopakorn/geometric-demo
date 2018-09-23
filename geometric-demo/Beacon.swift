//
//  Beacon.swift
//  geometric-demo
//
//  Created by Siam System Deverlopment on 20/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import Foundation
import CoreLocation

struct Beacon {
    let name: String
    var rssi: Int
    var accuracy: Double
    var proximity: String
    let major: NSNumber
    let minor: NSNumber
}

extension Beacon {
    init?(from json: [String: Any]) {
        guard
            let name = json["name"] as? String,
            let rssi = json["rssi"] as? Int,
            let accuracy = json["accuracy"] as? Double,
            let proximity = json["proximity"] as? String,
            let major = json["major"] as? NSNumber,
            let minor = json["minor"] as? NSNumber
            else { return nil }
        
        self.init(name: name, rssi: rssi, accuracy: accuracy, proximity: proximity, major: major, minor: minor)
    }
}

extension CLProximity {
    func toString() -> String {
        switch self {
        case .immediate:
            return "immediate"
        case .near:
            return "near"
        case .far:
            return "far"
        case .unknown:
            return "unknown"
        }
    }
}
