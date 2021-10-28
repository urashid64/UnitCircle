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

        // Times New Roman font to display angles
        let timesNR = UIFont.init(name: "TimesNewRomanPS-BoldMT", size: 22.0)!
        valRadians.setFont(font: timesNR)
        valDegrees.setFont(font: timesNR)

        // Red & Blue for X & Y coordinates
        valX.setTextColor(color: .red)
        valY.setTextColor(color: .blue)

        // Tap Recognizer to select the closest angle
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 1
        qView.addGestureRecognizer(tapRecognizer)
        
        // Start with fractions
        optFracDecimal.selectedSegmentIndex = 0
        updateTrigLabels()
    }


    func updateTrigLabels () {
        let tv = TrigData.instance.currentTrigValues()

        valRadians.setFraction(tv.angle.rad)
        valDegrees.setFraction(tv.angle.deg)

        // Display fractions or decimals based on the option selected
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

        // Refresh to display new values
        qView.setNeedsDisplay()
    }

    //
    // UI Action Handlers
    //

    @IBAction func toggleFracDecimal(_ sender: UISegmentedControl) {
        updateTrigLabels()
    }


    @objc func handleTap (recognizer: UITapGestureRecognizer) {
        let tapped = recognizer.location(in: qView)
        let (newAxis, newStep) = qView.closestAngle(to: tapped)
        
        TrigData.instance.setAngle(axis: newAxis, step: newStep)
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
