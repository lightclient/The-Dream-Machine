//
//  SleepViewController.swift
//  DreamMachine
//
//  Created by Matt Garnett on 11/26/16.
//  Copyright © 2016 Matt Garnett. All rights reserved.
//

import Foundation
import UIKit

class SleepViewController: UIViewController {
    
    var timeUntilREM = [Int]()
    var currentREM = 0
    
    var backgroundColors = [UIColor(red:1.00, green:0.39, blue:0.39, alpha:1.0) , UIColor(red:1.00, green:0.26, blue:0.26, alpha:1.0), UIColor(red:0.94, green:0.40, blue:0.40, alpha:1.0), UIColor(red:1.00, green:0.22, blue:0.22, alpha:1.0)]
    var backgroundLoop = 0
    
    var timer: Timer = Timer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        gestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gestureRecognizer)
        
        let debug = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        debug.numberOfTouchesRequired = 2
        debug.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(debug)
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            timer in
            
            if(self.timeUntilREM[self.currentREM] == 0) {
                
                self.currentREM += 1
                
                if(self.timeUntilREM.count <= self.currentREM) {
                    timer.invalidate()
                }
                
                self.performFlash()
                
                return
            }
            
            self.timeUntilREM[self.currentREM] -= 1
            print(String(describing: self.timeUntilREM[self.currentREM]))
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func doubleTapped(gestureRecognizer: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tripleTapped(gestureRecognizer: UIGestureRecognizer) {
        timeUntilREM[currentREM % timeUntilREM.count] = 5
    }
    
    func updateCounter() {
        timeUntilREM[currentREM] -= 1
        
        if(timeUntilREM[currentREM] <= 0) {
            timer.invalidate()
            performFlash()
        }
    }
    
    func performFlash () {
        if backgroundLoop < 20 {
            backgroundLoop += 1
            UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.view.backgroundColor =  self.backgroundColors[self.backgroundLoop % 4];
                }) {(Bool) -> Void in
                    self.performFlash();
            }
        } else {
            UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                self.view.backgroundColor =  UIColor.black;
            })
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
