//
//  CanvasViewController.swift
//  PaintApp
//
//  Created by Arianna O'Neil on 6/25/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

import UIKit

// UIView for drawing functionalities
class CanvasView: UIView {
    
    // calling line struct
    // empty array of lines
    fileprivate var lines = [Line]()
    
    // standard stroke color & stroke width
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1

    
    // setting stroke color
    func setStrokeColor(color: UIColor){
        self.strokeColor = color
    }
    
    // setting stroke width
    func setStrokeWidth(width: Float){
        self.strokeWidth = width
    }
    
    // painting begins here!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // calls to line struct 
        lines.forEach { (line) in
            
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.width))
            context.setLineCap(.round)
            
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    
    // new touch detected on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(width: strokeWidth, color: strokeColor, points: []))
    }
    
    // location of touch changes on view
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let point = touches.first?.location(in: nil) else
        { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    // undo button functionality through canvas logic
    func undoBtn() {
        _ = lines.popLast()
        setNeedsDisplay()
        
    }
    // clear button functionality through canvas logic
    func clearBtn() {
        lines.removeAll()
        setNeedsDisplay()
    }
}
