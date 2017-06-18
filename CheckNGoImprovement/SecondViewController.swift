//
//  SecondViewController.swift
//  naverPractice
//
//  Created by Minwoo Park on 6/18/17.
//  Copyright © 2017 MWdev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    
    
    @IBOutlet weak var passedID: UILabel!
    
    var loginID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passedID.text! = loginID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
