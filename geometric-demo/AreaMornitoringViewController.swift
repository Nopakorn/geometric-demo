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
    fileprivate let a = CGPoint(x: 42, y: 75)
    fileprivate let b = CGPoint(x: 42, y: 590)
    fileprivate let c = CGPoint(x: 330, y: 590)
    
    @IBOutlet weak var dALabel: UILabel!
    @IBOutlet weak var dBLabel: UILabel!
    @IBOutlet weak var dCLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingAPosition()
       
        let dA = 100;
        let dB = 415;
        let dC = 430;
        dALabel.text = "\(dA)"
        dBLabel.text = "\(dB)"
        dCLabel.text = "\(dC)"
//        let a = CGPoint(x: 100, y: 100)
//        let b = CGPoint(x: 160, y: 120)
//        let c = CGPoint(x: 70, y: 150)
//        let dA = 50.00;
//        let dB = 36.06;
//        let dC = 60.83;
        
//        let point = getCoordinate(BeaconA: a, BeaconB: b, BeaconC: c, distanceA: CGFloat(dA), distanceB: CGFloat(dB), distanceC: CGFloat(dC))
        
        let point = calCoordinates(BeaconA: a, BeaconB: b, BeaconC: c, distanceA: CGFloat(dA), distanceB: CGFloat(dB), distanceC: CGFloat(dC))
        print("_point is x \(point.x), y \(point.y)")
        //print("width \(view.frame.width), height \(view.frame.height)")
       // print("point is x:\(point.x) y:\(point.y)")
        
        
        let dAB = findDistance(PointA: a, PointB: b)
        let dBC = findDistance(PointA: b, PointB: c)
        let dCA = findDistance(PointA: c, PointB: a)
        print("distance ab \(dAB), bc \(dBC), ca \(dCA)")
        drawingCurrentCircle(x: point.x, y: point.y)
    }
    

    func drawingAPosition() {
        // 1
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: a.x, y: a.y), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.center = CGPoint(x: a.x, y: a.y-20)
        label.textAlignment = NSTextAlignment.center
        label.text = "(\(a.x.rounded()),\(a.y.rounded()))";
        label.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(label)
        view.layer.addSublayer(shapeLayer)
        
        // 2
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: b.x, y: b.y), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = circlePath2.cgPath
        shapeLayer2.fillColor = UIColor.blue.cgColor
        shapeLayer2.strokeColor = UIColor.blue.cgColor
        shapeLayer2.lineWidth = 3.0
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label2.center = CGPoint(x: b.x, y: b.y-20)
        label2.textAlignment = NSTextAlignment.center
        label2.text = "(\(b.x.rounded()),\(b.y.rounded()))";
        label2.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(label2)
        view.layer.addSublayer(shapeLayer2)
        
        // 3
        let circlePath3 = UIBezierPath(arcCenter: CGPoint(x: c.x, y: c.y), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = circlePath3.cgPath
        shapeLayer3.fillColor = UIColor.green.cgColor
        shapeLayer3.strokeColor = UIColor.green.cgColor
        shapeLayer3.lineWidth = 3.0
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label3.center = CGPoint(x: c.x, y: c.y-20)
        label3.textAlignment = NSTextAlignment.center
        label3.text = "(\(c.x.rounded()),\(c.y.rounded()))";
        label3.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(label3)
        view.layer.addSublayer(shapeLayer3)
    }
    
    func drawingCurrentCircle(x: CGFloat, y: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.purple.cgColor
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.lineWidth = 3.0
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.center = CGPoint(x: x, y: y-20)
        label.textAlignment = NSTextAlignment.center
        label.text = "(\(x.rounded()),\(y.rounded()))";
        label.font = UIFont.systemFont(ofSize: 12.0)
        view.addSubview(label)
        view.layer.addSublayer(shapeLayer)
    }
    
    func findDistance(PointA a: CGPoint, PointB b: CGPoint) -> CGFloat {
        let c1 = pow((b.x - a.x),2) + pow((b.y - a.y),2)
        let d = sqrt(c1)
        
        return d
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
    
    
    func calCoordinates(BeaconA a: CGPoint, BeaconB b: CGPoint, BeaconC c: CGPoint, distanceA dA: CGFloat, distanceB dB: CGFloat, distanceC dC: CGFloat) -> CGPoint {
        
        let c1 = (b.y-c.y)*(pow(a.x,2)-pow(b.x,2)+pow(a.y,2)-pow(b.y,2)-pow(dA,2)+pow(dB,2))

        let c2 = (a.y-b.y)*(pow(b.x,2)-pow(c.x,2)+pow(b.y,2)-pow(c.y,2)-pow(dB,2)+pow(dC,2))
        
        let x0 = (c2-c1)/(2*((b.y-c.y)*(b.x-a.x)-(a.y-b.y)*(c.x-b.x)))
        let y0 = (pow(a.x,2)-pow(b.x,2)-2*a.x*x0+2*b.x*x0+pow(a.y,2)-pow(b.y,2)-pow(dA,2)+pow(dB,2))/(2*(a.y-b.y))
        
        return CGPoint(x: x0, y: y0)
    }
}

