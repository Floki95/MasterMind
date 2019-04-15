//
//  FirstViewController.swift
//  MasterMind
//
//  Created by Thomas on 15/04/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

var mode = ""
var pseudo = ""

class FirstViewController: UIViewController  {
    
    
    @IBOutlet weak var pseudoTextField: UITextField!
    
    @IBOutlet weak var Pro: UIButton!
    
    @IBOutlet weak var training: UIButton!
    
    
    @IBAction func proButton(_ sender: UIButton) {
        mode = "pro"
        performSegue(withIdentifier: "seguePro", sender: self)
    }
    
    
    @IBAction func trainingButton(_ sender: UIButton) {
        mode = "training"
        performSegue(withIdentifier: "segueTraining", sender: self)
    }
    
    @IBAction func pseudoAction(_ sender: UITextField) {
        pseudo = sender.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
