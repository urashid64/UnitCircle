//
//  UIQuartzView.swift
//  UnitCircle
//
//  Created by Usman Rashid on 1/28/19.
//  Copyright © 2019 Usman Rashid. All rights reserved.
//

import UIKit

func * (lhs: Int, rhs: CGFloat) -> CGFloat { return CGFloat (lhs) * rhs }
func / (lhs: CGFloat, rhs: Int) -> CGFloat { return lhs / CGFloat (rhs) }

func + (lhs: CGFloat, rhs: Float) -> CGFloat { return lhs + CGFloat (rhs) }
func - (lhs: CGFloat, rhs: Float) -> CGFloat { return lhs - CGFloat (rhs) }

class UIQuartzView: UIView {

    // Each grid segment represents 0.2 units
    let gridSegments = 12

    enum axis {
        case plus_x
        case plus_y
        case minus_x
        case minus_y
    }

    enum step {
        case pi_by_six
        case pi_by_four
        case pi_by_three
    }
    
    let axisAngle : [axis:Float] = [
        .plus_x:     0.0,
        .plus_y:    .pi/2,
        .minus_x:   .pi,
        .minus_y:   .pi/2 * 3
    ]

    let stepAngle : [step:Float] = [
        .pi_by_six:     .pi/6,
        .pi_by_four:    .pi/4,
        .pi_by_three:   .pi/3
    ]
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        let context: CGContext = UIGraphicsGetCurrentContext()!
//        context.setFillColor(red:0.0, green:0.0, blue:0.0, alpha:1.0);
        
        drawBorder(context)
        drawGrid(context)
    }
    
    func drawBorder(_ context:CGContext) {
        // Top-Left corner of the view in view coordinates
        let origin = CGPoint (x:0.0, y:0.0)

        // Bottom-Right corner of the view in view coordinates
        let extent =  CGPoint (x:self.frame.width, y:self.frame.height)

        // Draw using default properties set in CG context
        context.move(to: origin)
        context.addLine(to: CGPoint(x:extent.x, y:origin.y))
        context.addLine(to: extent)
        context.addLine(to: CGPoint(x:origin.x, y:extent.y))
        context.addLine(to: origin)

        context.strokePath()
    }
    
    func drawGrid (_ context:CGContext) {
        // Save existing graphic state
        context.saveGState()
        
        // Size of Drawing Area in view coordinates
        let width = self.frame.width
        let height = self.frame.height
        
        // Origin of the drawing area
        let origin = CGPoint(x: 0.0, y: 0.0)

        // Center point of the drawing area
        let center = CGPoint (x: width/2.0, y: height/2.0)
        
        // Size of grid in view coordinates
        let gridSize = width / gridSegments
        
        // Set dashed pattern for grid lines
        context.setLineWidth(1.0)
        context.setLineDash(phase: 0.0, lengths: [1.0, 2.0])
        
        // Vertical grid lines
        for i in 0...gridSegments {
            context.move(to: CGPoint(x: i*gridSize, y: origin.y))
            context.addLine(to: CGPoint(x: i*gridSize, y: height))
        }
        context.strokePath()
        
        // Horizontal grid lines
        for i in 0...gridSegments {
            context.move(to: CGPoint(x: origin.x, y: i * gridSize))
            context.addLine(to: CGPoint(x: width, y: i * gridSize))
        }
        context.strokePath()

        // Use solid pattern for axis
        context.setLineDash(phase: 0.0, lengths: [])

        // Vertical Axis
        context.move(to: CGPoint(x: center.x, y: origin.y))
        context.addLine(to: CGPoint(x:center.x, y: height))

        // Horizontal Axis
        context.move(to: CGPoint(x:origin.x, y:center.y))
        context.addLine(to: CGPoint(x:width, y:center.y))

        // Draw the Unit Circle
        // Each grid segment = 0.2 units
        // 5 grid segments = 1.0 unit
        context.addArc(center: center, radius: gridSize * 5, startAngle: 0.0, endAngle: 2 * .pi, clockwise: false)
        context.strokePath()

        // Draw step lines in light gray
        context.setLineWidth(1.0)
        context.setStrokeColor(red:0.667, green:0.667, blue:0.667, alpha:1.0);
        
        for (_, base) in axisAngle {
            for (_, step) in stepAngle {
                drawLine(context, radius: Float(gridSize * 5.25), angle: base + step)
            }
        }

        // Restore previous graphic state
        context.restoreGState()
    }
    
    // Draw a radial line of specified length and at a specified positive angle
    func drawLine (_ context:CGContext, radius length:Float, angle theta:Float) {
        // Center point of the drawing area
        let center = CGPoint (x: self.frame.width/2.0, y: self.frame.height/2.0)
        
        // End point of the radial line
        let endPt = CGPoint (x: center.x + length * cos(theta), y: center.y - length * sin(theta))
        
        // Draw line
        context.move(to: center)
        context.addLine(to: endPt)
        
        context.strokePath()
    }
}
