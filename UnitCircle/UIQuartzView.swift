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
    private let gridSegments = 12
    
    // Top-Left corner of the view in view coordinates
    let origin = CGPoint (x: 0.0, y: 0.0)
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        // Extents of the drawing area
        drawBorder()
        
        // Components in the drawing ares
        // Includes the Grid, the unit circle, and step lines
        // Also highlights the current angle
        drawGrid()
        drawUnitCircle()
        drawStepLines()
        drawHighlight()
    }
    
    
    func drawBorder() {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // Save existing graphic state
        context.saveGState()

        // Bottom-Right corner of the view in view coordinates
        let extent =  CGPoint (x: frame.width, y: frame.height)

        // Draw using default properties set in CG context
        context.move(to: origin)
        context.addLine(to: CGPoint(x:extent.x, y:origin.y))
        context.addLine(to: extent)
        context.addLine(to: CGPoint(x:origin.x, y:extent.y))
        context.addLine(to: origin)

        context.strokePath()

        // Restore previous graphic state
        context.restoreGState()
    }


    func drawGrid () {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // Save existing graphic state
        context.saveGState()
        
        // Origin of the drawing area
        let origin = CGPoint(x: 0.0, y: 0.0)

        // Center point in view coordinates
        let center = CGPoint (x: frame.width/2.0, y: frame.height/2.0)

        // Size of grid in view coordinates
        let gridSize = frame.width / gridSegments
        
        // Set dashed pattern for grid lines
        context.setLineWidth(1.0)
        context.setLineDash(phase: 0.0, lengths: [1.0, 2.0])
        
        // Vertical grid lines
        for i in 0...gridSegments {
            context.move(to: CGPoint(x: i * gridSize, y: origin.y))
            context.addLine(to: CGPoint(x: i * gridSize, y: frame.height))
        }
        context.strokePath()
        
        // Horizontal grid lines
        for i in 0...gridSegments {
            context.move(to: CGPoint(x: origin.x, y: i * gridSize))
            context.addLine(to: CGPoint(x: frame.width, y: i * gridSize))
        }
        context.strokePath()

        // Use solid pattern for axis
        context.setLineDash(phase: 0.0, lengths: [])

        // Vertical Axis
        context.move(to: CGPoint(x: center.x, y: origin.y))
        context.addLine(to: CGPoint(x: center.x, y: frame.height))

        // Horizontal Axis
        context.move(to: CGPoint(x: origin.x, y: center.y))
        context.addLine(to: CGPoint(x: frame.width, y: center.y))

        context.strokePath()
        
        // Restore previous graphic state
        context.restoreGState()
    }


    func drawUnitCircle () {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // Save existing graphic state
        context.saveGState()

        // Center point in view coordinates
        let center = CGPoint (x: frame.width/2.0, y: frame.height/2.0)
        
        // Size of grid in view coordinates
        let gridSize = frame.width / gridSegments
        
        // Draw the Unit Circle
        // 5 grid segments = 1.0 unit
        context.setLineWidth(2.0)
        context.addArc(center: center, radius: gridSize * 5, startAngle: 0.0, endAngle: 2 * .pi, clockwise: false)
        context.strokePath()

        // Restore previous graphic state
        context.restoreGState()
    }


    func drawStepLines () {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // Save existing graphic state
        context.saveGState()
        
        // Center point in view coordinates
        let center = CGPoint (x: frame.width/2.0, y: frame.height/2.0)
        
        // Size of grid in view coordinates
        let gridSize = frame.width / gridSegments

       // Draw step lines in light gray
        context.setLineWidth(1.0)
        context.setStrokeColor(red:0.667, green:0.667, blue:0.667, alpha:1.0);
        
        let td = TrigData.instance
        for (_, (axis, _)) in td.axisAngle {
            for (_, (step, _)) in td.stepAngle {
                if (step > 0) {
                    drawLine(context, center: center, radius: Float(gridSize * 5.25), angle: axis+step)
                }
            }
        }

        // Restore previous graphic state
        context.restoreGState()
    }


    func drawHighlight () {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // Save existing graphic state
        context.saveGState()
        
        // Center point in view coordinates
        let center = CGPoint (x: frame.width/2.0, y: frame.height/2.0)

        // Size of grid in view coordinates
        let gridSize = frame.width / gridSegments
        
        // 5 grid segments = 1.0 unit
        let radius = Float(gridSize * 5.0)

        // Draw x,y components in double thickness
        context.setLineWidth(2.0)
        drawComponents(context, center: center, radius: radius, angle: TrigData.instance.currentAngle())
        
        // Draw highlight line in black
        context.setLineWidth(2.5)
        context.setStrokeColor(red:0.0, green:0.0, blue:0.0, alpha:1.0);
        drawLine(context, center: center, radius: radius, angle: TrigData.instance.currentAngle(), marker: true)

        // Restore previous graphic state
        context.restoreGState()
    }

    // Helper Functions
    
    // Find closest axis + step for a given point in view coordinates
    func closestAngle (to pt:CGPoint) -> (TrigData.axis, TrigData.step) {
        // Center point in view coordinates
        let center = CGPoint (x: frame.width/2.0, y: frame.height/2.0)
        // Size of grid in view coordinates
        let gridSize = frame.width / gridSegments
        
        // 5 grid segments = 1.0 unit
        let radius = Float(gridSize * 5.0)

        // Initial values
        var closestDist = CGFloat.greatestFiniteMagnitude
        var closestAxis = TrigData.axis.plus_x
        var closestStep = TrigData.step.zero

        let td = TrigData.instance
        for (axis, (radAxis, _)) in td.axisAngle {
            for (step, (radStep, _)) in td.stepAngle {
                // Locate the point on circle for each angle
                let ptOnCircle = CGPoint(x:center.x + radius * cos(radAxis + radStep), y: center.y - radius * sin(radAxis + radStep))
                
                // Calculate its distance from the tap point
                let dist = (pt.x - ptOnCircle.x) * (pt.x - ptOnCircle.x) + (pt.y - ptOnCircle.y) * (pt.y - ptOnCircle.y)
                
                // Keep track of the shortest distance
                if  dist < closestDist  {
                    closestDist = dist
                    closestAxis = axis
                    closestStep = step
                }
            }
        }
        
        // Return Axis and step corresponding to the closest angle
        return (closestAxis, closestStep)
    }


    // Draw a radial line of specified length and at a specified positive angle
    func drawLine (_ context:CGContext, center: CGPoint, radius length:Float, angle theta:Float, marker:Bool = false) {
    
        // End point of the radial line
        let endPt = CGPoint (x: center.x + length * cos(theta), y: center.y - length * sin(theta))
        
        // Draw line
        context.move(to: center)
        context.addLine(to: endPt)
        context.strokePath()

        // Draw a circle at the end point if asked
        if marker == true {
            let markerSize = frame.width / gridSegments / 3
            context.setFillColor(gray: 0.0, alpha: 1.0)
            context.fillEllipse(in: CGRect(origin: CGPoint(x:endPt.x - markerSize/2, y: endPt.y - markerSize/2),
                                           size: CGSize(width: markerSize, height: markerSize)))
            context.strokePath()
        }
    }


    // Draw x, y components of the current angle
    func drawComponents (_ context:CGContext, center: CGPoint, radius length:Float, angle theta:Float) {
        let endPtX = CGPoint (x: center.x + length * cos(theta), y: center.y)
        let endPtY = CGPoint (x: center.x + length * cos(theta), y: center.y - length * sin(theta))

        // X component in Red from center to end point on x-axis
        context.setStrokeColor(red:1.0, green:0.0, blue:0.0, alpha:1.0)
        context.move(to: center)
        context.addLine(to: endPtX)
        context.strokePath()

        // Y component in Blue from end point on x-axis to end Pt on circle
        context.setStrokeColor(red:0.0, green:0.0, blue:1.0, alpha:1.0)
        context.move(to: endPtX)
        context.addLine(to: endPtY)
        context.strokePath()
    }
}
