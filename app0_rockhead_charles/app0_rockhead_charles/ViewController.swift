//
//  ViewController.swift
//  app0_rockhead_charles
//
//  Created by Charles Rockhead on 9/9/20.
//  Copyright © 2020 Charles Rockhead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var colorLbl: UILabel!
    
    @IBOutlet weak var colorBttn: UIButton!
    
    //called when screen loads for first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //initial set up
        colorLbl.text = "Blue"
        colorBttn.setTitle("Turn Red", for: .normal)
        
        
    }
    
    //actual action when button is pressed
    @IBAction func changeColor(_ sender: Any) {
      
        let currLabel = colorLbl.text

        //if it is currently blue
        if (currLabel == "Blue") {
            //turn red
            colorLbl.text = "Red"
            colorBttn.setTitle("Turn Blue", for: .normal)
            
        } else {
            //button should say turn blueturn blue
            colorLbl.text = "Blue"
            colorBttn.setTitle("Turn Red", for: .normal)
        }
    
        
        
        
    }
    

}

