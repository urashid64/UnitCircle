//
//  TrigData.swift
//  UnitCircle
//
//  Created by Usman Rashid on 2/12/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import Foundation

class TrigData {
    static let instance = TrigData()
    private init(){}
    
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
}
