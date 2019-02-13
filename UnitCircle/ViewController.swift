//
//  ViewController.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/28/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Angle values
    @IBOutlet weak var valRadians: UIFractionView!
    @IBOutlet weak var valDegrees: UIFractionView!
    
    // Trig values
    @IBOutlet weak var qView: UIQuartzView!
    @IBOutlet weak var valSin: UIFractionView!
    @IBOutlet weak var valCos: UIFractionView!
    @IBOutlet weak var valTan: UIFractionView!
    @IBOutlet weak var valCosec: UIFractionView!
    @IBOutlet weak var valSec: UIFractionView!
    @IBOutlet weak var valCot: UIFractionView!

    // Coordinates
    @IBOutlet weak var valX: UIFractionView!
    @IBOutlet weak var valY: UIFractionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let timesNR = UIFont.init(name: "TimesNewRomanPSMT", size: 22.0)!
        valRadians.setFont(font: timesNR)
        valDegrees.setFont(font: timesNR)

        valX.setTextColor(color: .red)
        valY.setTextColor(color: .blue)

        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 1
        qView.addGestureRecognizer(tapRecognizer)

        updateTrigLabels()
    }


    func updateTrigLabels () {
        
        let tv = TrigData.instance.currentTrigValues()
        valRadians.setFraction(tv.angle.rad)
        valDegrees.setFraction(tv.angle.deg)
        
        valSin.setFraction(tv.sin.0)
        valCos.setFraction(tv.cos.0)
        valTan.setFraction(tv.tan.0)
        
        valSec.setFraction(tv.sec.0)
        valCosec.setFraction(tv.csc.0)
        valCot.setFraction(tv.cot.0)
        
        valX.setFraction(tv.cos.0)
        valY.setFraction(tv.sin.0)

        // Refresh to draw new highlighted angle
        qView.setNeedsDisplay()
    }


    @objc func handleTap (_: UITapGestureRecognizer) {
        TrigData.instance.nextAngle()
        updateTrigLabels()
    }
}
