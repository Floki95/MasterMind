//
//  ViewController.swift
//  MasterMind
//
//  Created by Thomas on 12/04/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ViewColorChoice: UIView!
    
    @IBOutlet var buttonsBoard: [UIButton]!
    
    @IBOutlet var labelPin: [UILabel]!
    
    @IBOutlet var buttonsMaster: [UIButton]!
    
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var LabelMode: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    var timer:Timer?
    var timeLeft = 200
    
    var modeChosen = ""
    var buttonBoardIndex = 0
    var turn = 0
    var colorMaster = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
    var colorTest = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
    
    
    override func viewDidAppear(_ animated: Bool) {
        modeChosen = mode
        if modeChosen == "pro" {
            LabelMode.text = "Mode PRO"
        } else {
            LabelMode.text = "Entraînement trankil"
        }
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft) seconds left"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            looserTime()
        }
    }
    
    func startTimer (){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func disableGame (){
        for nbDeLignes in 0...23 {
            buttonsBoard[nbDeLignes].isEnabled = false
            
        }
       ViewColorChoice.isUserInteractionEnabled = false
    }
    
    func looser (){
       disableGame ()
        LabelMode.text = "Looser, ridicule"
        for nbDeLignes in 0..<buttonsMaster.count {
            buttonsMaster[nbDeLignes].backgroundColor = colorMaster[nbDeLignes]
        }
        if mode == "pro"{
            timer?.invalidate()
            timer = nil
        }
        startButton.setTitle("RESTART !",for: UIControlState.normal)
        startButton.isEnabled = true
    }
    
    func looserTime (){
        disableGame ()
        LabelMode.text = "Looser, ridicule"
        for nbDeLignes in 0..<buttonsMaster.count {
            buttonsMaster[nbDeLignes].backgroundColor = colorMaster[nbDeLignes]
        }
        startButton.setTitle("RESTART !",for: UIControlState.normal)
        startButton.isEnabled = true
    }
    
    func win(){
        disableGame()
        labelScore.text = "Win, Score : \(turn)"
        
        for nbDeLignes in 0..<buttonsMaster.count {
            buttonsMaster[nbDeLignes].backgroundColor = colorMaster[nbDeLignes]
        }
        startButton.setTitle("RESTART !",for: UIControlState.normal)
        startButton.isEnabled = true
        
        if mode == "pro"{
            timer?.invalidate()
            timer = nil
        }
    }
    
    func restart () {
        turn  = 0
        buttonBoardIndex = 0
        let firstDisable = 0
        let lastDisable = buttonsBoard.count
        
        for i in firstDisable..<lastDisable{
            buttonsBoard[i].backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            buttonsBoard[i].isEnabled = false
            labelPin[i].backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        
        for i in 0...3 {
            buttonsMaster[i].backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        ViewColorChoice.isUserInteractionEnabled = true
        
        if modeChosen == "pro" {
            timeLeft = 200
        }
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        print("touchButton")
        if let buttonNumber = buttonsBoard.index(of: sender){
            print("buttonBoard number = \(buttonNumber)")
          
            //remove border from last button
            buttonsBoard[buttonBoardIndex].layer.borderWidth = 0
            //set index of the last button touched
            buttonBoardIndex = buttonNumber
            //set border to the button touched
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor.black.cgColor
        } else {
            print("button pas trouvé dans buttonsBoard")
        }
        
    }
    
    @IBAction func touchButtonColor(_ sender: UIButton) {
        buttonsBoard[buttonBoardIndex].backgroundColor = sender.backgroundColor
        
            let firstDisable = turn * 4
            let lastDisable = (turn * 4) + 3
 
        var ligneComplete = true
        
        for i in firstDisable...lastDisable{
            if buttonsBoard[i].backgroundColor == #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) {
                ligneComplete = false
                break
            }
        }
        
        if ligneComplete == true {
            startButton.isEnabled = true
        }
    }

    @IBAction func endTurn(_ sender: UIButton) {
        var titleValueString = sender.currentTitle!
        print(titleValueString)
        
        startButton.isEnabled = false
        
        if titleValueString=="RESTART !"{
            restart()
            titleValueString = "START !"
        }
        
        if titleValueString=="START !"{
            sender.setTitle("GO !",for: UIControlState.normal)
            
            if modeChosen == "pro"{
                startTimer()
            } else {
                labelScore.text = "Prends ton temps"
            }
            
            for nbDeLignes in 0..<4 {
                buttonsBoard[nbDeLignes].isEnabled = true
                //print(nbDeLignes)
            }
            
            for nbDeLignes in 0..<buttonsMaster.count {
                let color = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1),#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)]
                let randomNum =  Int(arc4random_uniform(6))
                colorMaster[nbDeLignes] = color[randomNum]
               // buttonsMaster[nbDeLignes].backgroundColor = colorMaster[nbDeLignes]
            }
            
        }
        else if turn < 6 {
            turn += 1
            
            let firstEnable = turn*4
            let lastEnable = turn*4+3

            if turn < 6 {
                //enable next row of button
                for nbDeLignes in firstEnable...lastEnable {
                    buttonsBoard[nbDeLignes].isEnabled = true
                    //print(nbDeLignes)
                }
            }
        
            let firstDisable = (turn-1)*4
            let lastDisable = (turn-1)*4+3
            
            //disable last row of button
            for nbDeLignes in firstDisable...lastDisable {
                buttonsBoard[nbDeLignes].isEnabled = false
            }
            
            //set clew
            
            for nbDeLignes in 0..<colorTest.count {
                colorTest[nbDeLignes] = colorMaster[nbDeLignes]
            }
 
            var indexClew = firstDisable
            var indexColorTest = 0
            //on test d'abord s'ils sont a la bonne place
            
            var checked = [false,false,false,false]
            var indexCheck = 0
            
             for i in firstDisable...lastDisable {
                if buttonsBoard[i].backgroundColor == colorTest[indexColorTest]{
                    colorTest[indexColorTest]=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    labelPin[indexClew].backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                    checked[indexCheck] = true
                    indexClew += 1
                    print("indexclew \(indexClew)")
                }
                indexCheck += 1
                indexColorTest += 1
            }
            
            indexCheck = 0
            
            for i in firstDisable...lastDisable {
                
                for y in 0...3 {
                    
                    if buttonsBoard[i].backgroundColor == colorTest[y]{
                        colorTest[y]=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        if (i != y && checked[indexCheck] == false) {
                            labelPin[indexClew].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                            indexClew += 1
                            //on a trouvé on sort de la boucle
                            break
                        }
                    }
                }
                indexCheck += 1
            }
            

         //   print("indexclew \(indexClew)")
            
            var isWin = true
            //test si win
            
            for i in firstDisable...lastDisable{
                if labelPin[i].backgroundColor != #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) {
                    isWin = false
                    break
                }
            }
            
            if isWin == true {
               win()
            }else if turn == 6 {
                looser()
            }
            
            buttonBoardIndex = firstEnable;
            
        }
        
    }
    
}

