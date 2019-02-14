//
//  TrigData.swift
//  UnitCircle
//
//  Created by Usman Rashid on 2/12/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import Foundation

struct TrigValues {
    let angle: (rad: String, deg: String)
    let sin: (String, String)
    let cos: (String, String)
    let tan: (String, String)
    let sec: (String, String)
    let csc: (String, String)
    let cot: (String, String)
}


class TrigData {
    static let instance = TrigData()

    private init() {
        initTrigValues()
    }

    // Base axis for each quadrant
    enum axis: CaseIterable {
        case plus_x
        case plus_y
        case minus_x
        case minus_y
    }

    // Angle for each base axis (radians, degs)
    let axisAngle: [axis : (Float, Int)] = [
        .plus_x:    (    0.0,   0),
        .plus_y:    (  .pi/2,  90),
        .minus_x:   (    .pi, 180),
        .minus_y:   (.pi/2*3, 270)
    ]

    // Offsets of interest from the base axis
    enum step: CaseIterable {
        case zero
        case pi_by_6
        case pi_by_4
        case pi_by_3
    }

    // Angle for each offset (radians, degs)
    let stepAngle: [step : (Float, Int)] = [
        .zero:    (  0.0,  0),
        .pi_by_6: (.pi/6, 30),
        .pi_by_4: (.pi/4, 45),
        .pi_by_3: (.pi/3, 60)
    ]

    var currentAxis: axis = .plus_x
    var currentStep: step = .pi_by_6

    var trigValues: [Int : TrigValues] = [:]

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

    // Move to next Angle
    func nextAngle () {
        let nextStepIndex = (step.allCases.index(of: currentStep)! + 1) % step.allCases.count
        currentStep = step.allCases[nextStepIndex]

        if nextStepIndex == 0 {
            let nextAxisIndex = (axis.allCases.index(of: currentAxis)! + 1) % axis.allCases.count
            currentAxis = axis.allCases[nextAxisIndex]
        }
    }

    // Move to previous Angle
    func prevAngle () {
        let prevStepIndex = (step.allCases.index(of: currentStep)! + step.allCases.count - 1) % step.allCases.count
        currentStep = step.allCases[prevStepIndex]

        if prevStepIndex == step.allCases.count - 1 {
            let prevAxisIndex = (axis.allCases.index(of: currentAxis)! + axis.allCases.count - 1) % axis.allCases.count
            currentAxis = axis.allCases[prevAxisIndex]
        }
    }

    // Move to specific Angle
    func setAngle (axis:axis, step:step) {
        currentAxis = axis
        currentStep = step
    }

    // Text for trig values for the current axis + step
    func currentTrigValues () -> TrigValues {
        let axis = axisAngle[currentAxis]!.1
        let step = stepAngle[currentStep]!.1
        return trigValues[axis + step]!
    }

    // Value of current axis + step in radians
    func currentAngle () -> Float {
        return axisAngle[currentAxis]!.0 + stepAngle[currentStep]!.0
    }
}
