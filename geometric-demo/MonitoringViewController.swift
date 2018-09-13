//
//  ViewController.swift
//  geometric-demo
//
//  Created by Nopakorn Ganjanasinit on 13/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import UIKit
import KontaktSDK

class MonitoringViewController: UIViewController {
    var beaconManager: KTKBeaconManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager = KTKBeaconManager(delegate: self)
        let myProximityUuid = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon JsSgHh")
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            beaconManager.requestLocationAlwaysAuthorization()
        case .denied, .restricted:
            print("location denied")
        case .authorizedWhenInUse:
            // For most iBeacon-based app this type of
            // permission is not adequate
            print("location authorizedWhenInUse")
        case .authorizedAlways:
            print("location authorizedAlways")
            if KTKBeaconManager.isMonitoringAvailable() {
                beaconManager.startMonitoring(for: region)
            }
        }
        
        
       
    }
}

extension MonitoringViewController: KTKBeaconManagerDelegate {
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // When status changes to CLAuthorizationStatus.authorizedAlways
            // e.g. after calling beaconManager.requestLocationAlwaysAuthorization()
            // we can start region monitoring from here
        }
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        // Do something when monitoring for a particular
        // region is successfully initiated
    }
    
    func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: NSError?) {
        // Handle monitoring failing to start for your region
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        // Decide what to do when a user enters a range of your region; usually used
        // for triggering a local notification and/or starting a beacon ranging
        manager.startRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        // Decide what to do when a user exits a range of your region; usually used
        // for triggering a local notification and stoping a beacon ranging
        manager.stopRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        for beacon in beacons {
            print("Ranged beacon with Proximity UUID: \(beacon.proximityUUID), Major: \(beacon.major) and Minor: \(beacon.minor) from \(region.identifier) in \(beacon.proximity) proximity")
        }
    }
}
