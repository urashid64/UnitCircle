//
//  ViewController.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/28/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

// Base axis for each quadrant
enum axis : CaseIterable {
    case plus_x
    case plus_y
    case minus_x
    case minus_y
}

// Angle for each base axis (in radians)
let axisAngle: [axis : (Float, Int)] = [
    .plus_x:    (0.0,         0),
    .plus_y:    (.pi/2,      90),
    .minus_x:   (.pi,       180),
    .minus_y:   (.pi/2*3,   270)
]

// Offsets of interest from the base axis
enum step : CaseIterable {
    case zero
    case pi_by_six
    case pi_by_four
    case pi_by_three
}

// Angle for each offset (in radians)
let stepAngle: [step : (Float, Int)] = [
    .zero:          (  0.0,  0),
    .pi_by_six:     (.pi/6, 30),
    .pi_by_four:    (.pi/4, 45),
    .pi_by_three:   (.pi/3, 60)
]

var currentAxis : axis = .plus_x
var currentStep : step = .pi_by_six

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

    struct TrigValues {
        let angle: (String, String)
        let sin: (String, String)
        let cos: (String, String)
        let tan: (String, String)
        let sec: (String, String)
        let csc: (String, String)
        let cot: (String, String)
    }

    var trigValues: [Int : TrigValues] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initTrigValues()

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


    func initTrigValues () {
        trigValues[  0] = TrigValues(angle: ("0", "0º"),
                                     sin:("0", "0.0"), cos:("1", "1.0"), tan:("0", "0.0"), sec:("1", "1.0"), csc:("undef", "undef"), cot:("undef", "undef"))
        
        trigValues[ 30] = TrigValues(angle: ("π/6", "30º"),
                                     sin:("1/2", "0.5"), cos:("√3/2", "0.866"), tan:("1/√3", "0.577"), sec:("2/√3", "1.155"), csc:("2", "2.0"), cot:("√3", "1.732"))
        
        trigValues[ 45] = TrigValues(angle: ("π/4", "45º"),
                                     sin:("√2/2", "0.707"), cos:("√2/2", "0.707"), tan:("1", "1.0"), sec:("√2", "1.414"), csc:("√2", "1.414"), cot:("1", "1.0"))
        
        trigValues[ 60] = TrigValues(angle: ("π/3", "60º"),
                                     sin:("√3/2", "0.866"), cos:("1/2", "0.5"), tan:("√3", "1.732"), sec:("2", "2.0"), csc:("2/√3", "1.155"), cot:("1/√3", "0.577"))
        
        trigValues[ 90] = TrigValues(angle: ("π/2", "90º"),
                                     sin:("1", "1.0"), cos:("0", "0.0"), tan:("undef", "undef"), sec:("undef", "undef"), csc:("1", "1.0"), cot:("0", "0.0"))
        
        trigValues[120] = TrigValues(angle: ("2π/3", "120º"),
                                     sin:("√3/2", "0.866"), cos:("-1/2", "-0.5"), tan:("-√3", "-1.732"), sec:("-2", "-2.0"), csc:("2/√3", "1.155"), cot:("-1/√3", "-0.577"))
        
        trigValues[135] = TrigValues(angle: ("3π/4", "135º"),
                                     sin:("√2/2", "0.707"), cos:("-√2/2", "-0.707"), tan:("-1", "-1.0"), sec:("-√2", "-1.414"), csc:("√2", "1.414"), cot:("-1", "-1.0"))
        
        trigValues[150] = TrigValues(angle: ("5π/6", "150º"),
                                     sin:("1/2", "0.5"), cos:("-√3/2", "-0.866"), tan:("-1/√3", "-0.577"), sec:("-2/√3", "-1.155"), csc:("2", "2.0"), cot:("-√3", "-1.732"))
        
        trigValues[180] = TrigValues(angle: ("π", "180º"),
                                     sin:("0", "0.0"), cos:("-1", "-1.0"), tan:("0", "0.0"), sec:("-1", "-1.0"), csc:("undef", "undef"), cot:("undef", "undef"))
        
        trigValues[210] = TrigValues(angle: ("7π/6", "210º"),
                                     sin:("-1/2", "-0.5"), cos:("-√3/2", "-0.866"), tan:("1/√3", "0.577"), sec:("-2/√3", "-1.155"), csc:("-2", "-2.0"), cot:("√3", "1.732"))
        
        trigValues[225] = TrigValues(angle: ("5π/4", "225º"),
                                     sin:("-√2/2", "-0.707"), cos:("-√2/2", "-0.707"), tan:("1", "1.0"), sec:("-√2", "-1.414"), csc:("-√2", "-1.414"), cot:("1", "1.0"))
        
        trigValues[240] = TrigValues(angle: ("4π/3", "240º"),
                                     sin:("-√3/2", "-0.866"), cos:("-1/2", "-0.5"), tan:("√3", "1.732"), sec:("-2", "-2.0"), csc:("-2/√3", "-1.155"), cot:("1/√3", "0.577"))
        
        trigValues[270] = TrigValues(angle: ("3π/2", "270º"),
                                     sin:("-1", "-1.0"), cos:("0", "0.0"), tan:("undef", "undef"), sec:("undef", "undef"), csc:("-1", "-1.0"), cot:("0", "0.0"))
        
        trigValues[300] = TrigValues(angle: ("5π/3", "300º"),
                                     sin:("-√3/2", "-0.866"), cos:("1/2", "0.5"), tan:("-√3", "-1.732"), sec:("2", "2.0"), csc:("-2/√3", "-1.155"), cot:("-1/√3", "-0.577"))
        
        trigValues[315] = TrigValues(angle: ("7π/4", "315º"),
                                     sin:("-√2/2", "-0.707"), cos:("√2/2", "0.707"), tan:("-1", "-1.0"), sec:("√2", "1.414"), csc:("-√2", "-1.414"), cot:("-1", "-1.0"))
        
        trigValues[330] = TrigValues(angle: ("11π/6", "330º"),
                                     sin:("-1/2", "-0.5"), cos:("-√3/2", "-0.866"), tan:("1/√3", "0.577"), sec:("-2/√3", "-1.155"), csc:("-2", "-2.0"), cot:("√3", "1.732"))
    }


    func updateTrigLabels () {
        let axis = axisAngle[currentAxis]!.1
        let step = stepAngle[currentStep]!.1
        
        valRadians.setFraction(str: trigValues[axis+step]!.angle.0)
        valDegrees.setFraction(str: trigValues[axis+step]!.angle.1)
        
        valSin.setFraction(str: trigValues[axis+step]!.sin.0)
        valCos.setFraction(str: trigValues[axis+step]!.cos.0)
        valTan.setFraction(str: trigValues[axis+step]!.tan.0)
        
        valSec.setFraction(str: trigValues[axis+step]!.sec.0)
        valCosec.setFraction(str: trigValues[axis+step]!.csc.0)
        valCot.setFraction(str: trigValues[axis+step]!.cot.0)
        
        valX.setFraction(str: trigValues[axis+step]!.cos.0)
        valY.setFraction(str: trigValues[axis+step]!.sin.0)

        // Refresh to draw new highlighted angle
        qView.setNeedsDisplay()
    }


    @objc func handleTap (_: UITapGestureRecognizer) {
        let nextStepIndex = (step.allCases.index(of: currentStep)! + 1) % step.allCases.count
        currentStep = step.allCases[nextStepIndex]
        
        if nextStepIndex == 0 {
            let nextAxisIndex = (axis.allCases.index(of: currentAxis)! + 1) % axis.allCases.count
            currentAxis = axis.allCases[nextAxisIndex]
        }
        updateTrigLabels()
    }
}
