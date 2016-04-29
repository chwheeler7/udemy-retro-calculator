//
//  ViewController.swift
//  retro-calculator
//
//  Created by Chris Wheeler on 4/27/16.
//  Copyright © 2016 Chris Wheeler. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var screenLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = "0"
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        screenLbl.text = runningNumber
    }

    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func minusPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func plusPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        runningNumber = ""
        leftValStr = "0"
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        screenLbl.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
            }
            
            leftValStr = result
            screenLbl.text = result
            
            currentOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

