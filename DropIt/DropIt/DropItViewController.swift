//
//  DropItViewController.swift
//  DropIt
//
//  Created by Rashdan Natiq on 21/11/2017.
//  Copyright © 2017 Danish Ali. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController
{
    
    @IBOutlet weak var gameView: DropItView!{
        didSet {
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(recognizer:))))
        }
    }
    
    func addDrop(recognizer: UITapGestureRecognizer) {
    
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameView.animating = false
    }
}
