//
//  AuthorizedViewController.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import UIKit

class AuthorizedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.tableView.reloadData()
        }) { error in
            print(error.description)
        }

        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }

}
