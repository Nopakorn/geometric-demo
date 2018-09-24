//
//  BeaconTableViewController.swift
//  geometric-demo
//
//  Created by Siam System Deverlopment on 20/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import UIKit
import KontaktSDK
import CoreBluetooth

class BeaconTableViewController: UITableViewController {
    fileprivate var beacons = [Beacon]()
    fileprivate var beaconManager: KTKBeaconManager!
    fileprivate var centralManager: CBCentralManager!
    fileprivate var region: KTKBeaconRegion!

    @IBOutlet weak var bluetoothIconNav: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem().itemWith(colorfulImage: nil, title: "Scan", target: self, action: #selector(pressScanButton(_:)))
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.global())
        centralManager.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 115
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        setUpBeacons()
        
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
        let myProximityUuid = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
        region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon OTRT")
        region.notifyOnExit = true
        region.notifyOnEntry = true
    }
    
    func setUpBeacons() {
        let beacon1JSON:[String: Any] = [
            "name": "Beacon JsUSPg",
            "accuracy": 0.0,
            "rssi": 0,
            "proximity": "no",
            "major": 64209,
            "minor": 44429
        ]
        
        let beacon2JSON:[String: Any] = [
            "name": "Beacon JsSgHh",
            "accuracy": 0.0,
            "rssi": 0,
            "proximity": "no",
            "major": 22816,
            "minor": 19687
        ]
        
        let beacon3JSON:[String: Any] = [
            "name": "Beacon Js2I5t",
            "accuracy": 0.0,
            "rssi": 0,
            "proximity": "no",
            "major": 27755,
            "minor": 9767
        ]
        var _te = Beacon(from: beacon1JSON)
        
        _te?.accuracy = 10.0
        
        beacons.append(Beacon(from: beacon1JSON)!)
        beacons.append(Beacon(from: beacon2JSON)!)
        beacons.append(Beacon(from: beacon3JSON)!)
    }
    
    func updateBeacon(_ clBeacon: CLBeacon) {
        beacons = beacons.map {
            var x = $0
            if(x.major == clBeacon.major) {
                x.rssi = clBeacon.rssi
                x.accuracy = clBeacon.accuracy
                x.proximity = clBeacon.proximity.toString()
            }
            
            return x
            }.sorted { $0.accuracy < $1.accuracy }
        
        tableView.reloadData()
    }
    
    //The target function
    @objc func pressScanButton(_ sender: UIButton){
        if sender.title(for: .normal) == "Scan" {
            startMornitoring()
        } else {
            stopMornitoring()
        }
    }
    
    fileprivate func startMornitoring() {
        //scan
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined, .denied, .restricted:
            self.popUpLocationPermission()
        case .authorizedWhenInUse, .authorizedAlways:
            if KTKBeaconManager.isMonitoringAvailable() {
                beaconManager.stopMonitoringForAllRegions()
                beaconManager.startMonitoring(for: region)
                navigationItem.leftBarButtonItem = UIBarButtonItem().itemWith(colorfulImage: nil, title: "Stop", target: self, action: #selector(pressScanButton(_:)))
            }
        }
    }
    
    fileprivate func stopMornitoring() {
        beaconManager.stopMonitoringForAllRegions()
        beaconManager.stopRangingBeaconsInAllRegions()
        navigationItem.leftBarButtonItem = UIBarButtonItem().itemWith(colorfulImage: nil, title: "Scan", target: self, action: #selector(pressScanButton(_:)))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopMornitoring()
    }
}

extension BeaconTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath) as! BeaconCell
        
        let _beaconFirst = beacons[indexPath.row]
        cell.setName(_beaconFirst.name)
        cell.setRssi("\(_beaconFirst.rssi)")
        let strAccuracy = "\(_beaconFirst.accuracy)"
        cell.setMeters(strAccuracy)
        cell.setProximity(_beaconFirst.proximity)
        
        return cell
    }
    
}

extension BeaconTableViewController: KTKBeaconManagerDelegate {
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("authorizeee")
        }
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
        if state.rawValue == 1 {
            startMornitoring()
        }
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        print("didstartmonitoring for \(region)")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print("monitoringdidfail \(error.debugDescription)")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        manager.startRangingBeacons(in: region)
        print("didenter major \(String(describing: region.major)), minor \(String(describing: region.minor))")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        manager.stopRangingBeacons(in: region)
        print("didexist major \(String(describing: region.major)), minor \(String(describing: region.minor))")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        for beacon in beacons {
            print("UUID: \(beacon.proximityUUID), Major: \(beacon.major) and Minor: \(beacon.minor) from \(region.identifier) in \(beacon.proximity) proximity, rssi: \(beacon.rssi) accuracy: \(beacon.accuracy)")
            _ = beacon.proximity
            updateBeacon(beacon)
        }
    }
}

extension BeaconTableViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            bluetoothIconNav.image = UIImage(named: "BleOn_")
        case .poweredOff:
            bluetoothIconNav.image = UIImage(named: "BleOff_")
        default:
            bluetoothIconNav.image = UIImage(named: "BleOff_")
            break;
        }
    }
    
}
