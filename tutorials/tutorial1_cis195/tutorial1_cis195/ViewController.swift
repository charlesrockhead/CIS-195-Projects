//
//  ViewController.swift
//  tutorial1_cis195
//
//  Created by Charles Rockhead on 9/17/20.
//  Copyright © 2020 Charles Rockhead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        print("viewWillAppear()")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        print("viewDidAppear()")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        print("viewWillDisappear()")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        print("viewDidDisappear()")
    }

}

