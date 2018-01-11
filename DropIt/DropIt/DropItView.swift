//
//  DropItView.swift
//  DropIt
//
//  Created by Rashdan Natiq on 21/11/2017.
//  Copyright © 2017 Danish Ali. All rights reserved.
//

import UIKit

class DropItView: UIView, UIDynamicAnimatorDelegate
{
 
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    
    }()
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    private let dropBehavior = FallingObjectBehavior()
    
    var animating: Bool = false {
        didSet{
            if animating {
                animator.addBehavior(dropBehavior)
                
            }
            else{
                animator.removeBehavior(dropBehavior)
                
            }
        }
    }
    
    private func removeCompletedRow()
    {
        var dropsToRemove = [UIView]()
        
        var hitTestRect = CGRect(origin: bounds.lowerLeft, size: dropSize)
        repeat {
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            var dropsTested = 0
            var dropsFound = [UIView]()
            while dropsTested < dropsPerRow{
                if let hitView = hitTest(p: hitTestRect.mid), hitView.superview == self {
                dropsFound.append(hitView)
            }
            else {
                break
            }
        
        hitTestRect.origin.x += dropSize.width
        dropsTested += 1
    }
    
        if dropsTested == dropsPerRow {
            dropsToRemove += dropsFound
        }
    } while dropsToRemove.count == 0 && hitTestRect.origin.y > bounds.minY
    for drop in dropsToRemove {
    dropBehavior.removeItem(item: drop)
    drop.removeFromSuperview()
    }
    }
private let dropsPerRow = 10
    
    private var dropSize: CGSize{
        let size = bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    func addDrop()
    {
        var frame = CGRect(origin: CGPoint.zero, size: dropSize)
        frame.origin.x = CGFloat.random(max: dropsPerRow) * dropSize.width
        
        let drop = UIView(frame: frame)
        drop.backgroundColor = UIColor.random
        
        addSubview(drop)
        dropBehavior.addItem(item: drop)
        
        
    }
}