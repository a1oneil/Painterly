//
//  EraseViewController.swift
//  PaintApp
//
//  Created by Arianna O'Neil on 7/2/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

import UIKit

class EraseView : UIView {
    
    override func draw(_ rect: CGRect) {
        // painting begins here
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.round)
        
        for (i, p) in line.enumerated() {
            if i == 0 {
                context.move(to: p)
                } else {
                context.addLine(to: p)
            }
        }
        context.strokePath()
    }
    var line = [CGPoint]()
}
    
