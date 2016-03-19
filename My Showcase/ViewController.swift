//
//  ViewController.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        } else {
            self.performSegueWithIdentifier(SEGUE_LOGIN, sender: nil)
        }
    }
    
}

