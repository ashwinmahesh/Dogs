//
//  ViewController.swift
//  Dogs
//
//  Created by Ashwin Mahesh on 7/11/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func addPushed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddSegue", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

