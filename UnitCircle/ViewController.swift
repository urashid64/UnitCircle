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

    // Graph
    @IBOutlet weak var qView: UIQuartzView!

    // Fraction / Decimal values switch
    @IBOutlet weak var optFracDecimal: UISegmentedControl!

    // Trig values
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
        
        // Start with fractions
        optFracDecimal.selectedSegmentIndex = 0
        updateTrigLabels()
    }


    func updateTrigLabels () {
        
        let tv = TrigData.instance.currentTrigValues()
        valRadians.setFraction(tv.angle.rad)
        valDegrees.setFraction(tv.angle.deg)

        if (self.optFracDecimal.selectedSegmentIndex == 0) {
            valSin.setFraction(tv.sin.0)
            valCos.setFraction(tv.cos.0)
            valTan.setFraction(tv.tan.0)

            valSec.setFraction(tv.sec.0)
            valCosec.setFraction(tv.csc.0)
            valCot.setFraction(tv.cot.0)

            valX.setFraction(tv.cos.0)
            valY.setFraction(tv.sin.0)
        }
        else {
            valSin.setFraction(tv.sin.1)
            valCos.setFraction(tv.cos.1)
            valTan.setFraction(tv.tan.1)
            
            valSec.setFraction(tv.sec.1)
            valCosec.setFraction(tv.csc.1)
            valCot.setFraction(tv.cot.1)
            
            valX.setFraction(tv.cos.1)
            valY.setFraction(tv.sin.1)
        }

        // Refresh to draw new highlighted angle
        qView.setNeedsDisplay()
    }

    //
    // UI Action Handlers
    //

    @IBAction func toggleFracDecimal(_ sender: UISegmentedControl) {
        updateTrigLabels()
    }


    @IBAction func moveClockwise(_ sender: UIButton) {
        TrigData.instance.prevAngle()
        updateTrigLabels()
    }


    @IBAction func moveCounterCW(_ sender: UIButton) {
        TrigData.instance.nextAngle()
        updateTrigLabels()
    }
}

/*
 ⤽
 TOP ARC ANTICLOCKWISE ARROW WITH PLUS
 Unicode: U+293D, UTF-8: E2 A4 BD

 ⤼
 TOP ARC CLOCKWISE ARROW WITH MINUS
 Unicode: U+293C, UTF-8: E2 A4 BC
*/
