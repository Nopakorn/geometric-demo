//
//  AreaMornitoringViewController.swift
//  geometric-demo
//
//  Created by Siam System Deverlopment on 24/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import UIKit
import KontaktSDK


class AreaMornitoringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        drawingAPosition()
        let a = CGPoint(x: view.frame.width, y: 100)
        let b = CGPoint(x: view.frame.width, y: view.frame.height - 100)
        let c = CGPoint(x: 0, y: view.frame.height - 100)
        let dA = 600;
        let dB = 79;
        let dC = 300;
        
        let point = getCoordinate(BeaconA: a, BeaconB: b, BeaconC: c, distanceA: CGFloat(dA), distanceB: CGFloat(dB), distanceC: CGFloat(dC))
        print("origin x \(view.frame.origin.x), y \(view.frame.origin.y)")
        print("width \(view.frame.width), height \(view.frame.height)")
        print("point is x:\(point.x) y:\(point.y)")
        drawingCurrentCircle(x: abs(point.x), y: abs(point.y / 2))
    }
    

    func drawingAPosition() {
        // 1
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width, y: 100), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
        
        // 2
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: view.frame.width, y: view.frame.height - 100), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = circlePath2.cgPath
        shapeLayer2.fillColor = UIColor.green.cgColor
        shapeLayer2.strokeColor = UIColor.green.cgColor
        shapeLayer2.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer2)
        
        // 3
        let circlePath3 = UIBezierPath(arcCenter: CGPoint(x: 0, y: view.frame.height - 100), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = circlePath3.cgPath
        shapeLayer3.fillColor = UIColor.blue.cgColor
        shapeLayer3.strokeColor = UIColor.blue.cgColor
        shapeLayer3.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer3)
    }
    
    func drawingCurrentCircle(x: CGFloat, y: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.purple.cgColor
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func getCoordinate(BeaconA a: CGPoint, BeaconB b: CGPoint, BeaconC c: CGPoint, distanceA dA: CGFloat, distanceB dB: CGFloat, distanceC dC: CGFloat) -> CGPoint {
        var W, Z, x, y, y2: CGFloat
        
        let wda = (dA * dA) - (dB * dB)
        let waxy = (a.x * a.x) - (a.y * a.y)
        
        let zdb = (dB * dB) - (dC * dC)
        let zbxy = (b.x * b.x) - (b.y * b.y)
        W = (wda - waxy) + (b.x * b.x) + (b.y * b.y)
        Z = (zdb - zbxy) + (c.x * c.x) + (c.y * c.y)
        
        x = (W * (c.y-b.y) - Z * (b.y-a.y)) / (2 * ((b.x-a.x) * (c.y-b.y) - (c.x-b.x) * (b.y-a.y)))
        let _reY = b.y-a.y == 0 ? 1 : b.y-a.y
        let _reX = c.y-b.y == 0 ? 1 : c.y-b.y
        y = (W - 2 * x * (b.x - a.x)) / (2 * (_reY))
        //y2 is a second measure of y to mitigate errors
        y2 = (Z - 2 * x * (c.x-b.x)) / (2 * (_reX))
        
        y = (y + y2) / 2
        return CGPoint(x: y, y: x)
    }

}

