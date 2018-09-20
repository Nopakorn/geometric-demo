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
    
    @IBOutlet weak var rssi27755Label: UILabel!
    @IBOutlet weak var rssi22816Label: UILabel!
    @IBOutlet weak var rssi64209Label: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
        let myProximityUuid = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon OTRT")
        
        region.notifyOnExit = true
        region.notifyOnEntry = true
        
        
        uuidLabel.text = "\(region.proximityUUID)"
        statusLabel.text = "not determine"
        
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            print("location notDetermined")
        case .denied, .restricted:
            print("location denied")
        case .authorizedWhenInUse:
            // For most iBeacon-based app this type of
            // permission is not adequate
            print("location authorizedWhenInUse")
        case .authorizedAlways:
            print("location authorizedAlways")
            if KTKBeaconManager.isMonitoringAvailable() {
                print("start")
                beaconManager.stopMonitoringForAllRegions()
                beaconManager.startMonitoring(for: region)
            }else {
                print("not available")
            }
        }
    }
    
    func displayRSSI(_ beacon: CLBeacon) {
        switch beacon.major {
        case 64209:
            rssi64209Label.text = "\(beacon.rssi)"
        case 22816:
            rssi22816Label.text = "\(beacon.rssi)"
        case 27755:
            rssi27755Label.text = "\(beacon.rssi)"
        default:
            break
        }
    }
}

extension MonitoringViewController: KTKBeaconManagerDelegate {
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("authorizeee")
        }
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
        print("determine \(state.hashValue.description), region \(region.proximityUUID)")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        // Do something when monitoring for a particular
        // region is successfully initiated
        print("didstartmonitoring for \(region)")
        statusLabel.text = "start monitoring"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: NSError?) {
        // Handle monitoring failing to start for your region
        print("monitoringdidfail \(error.debugDescription)")
        statusLabel.text = "failed monitoring"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        // Decide what to do when a user enters a range of your region; usually used
        // for triggering a local notification and/or starting a beacon ranging
        manager.startRangingBeacons(in: region)
        print("didenter major \(region.major), minor \(region.minor)")
        statusLabel.text = "enter region"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        // Decide what to do when a user exits a range of your region; usually used
        // for triggering a local notification and stoping a beacon ranging
        manager.stopRangingBeacons(in: region)
        print("didexist major \(region.major), minor \(region.minor)")
        statusLabel.text = "exit region"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        for beacon in beacons {
            print("UUID: \(beacon.proximityUUID), Major: \(beacon.major) and Minor: \(beacon.minor) from \(region.identifier) in \(beacon.proximity) proximity, rssi: \(beacon.rssi) accuracy: \(beacon.accuracy)")
            displayRSSI(beacon)
        }
    }
}
