//
//  CustomCell.swift
//  Dogs
//
//  Created by Ashwin Mahesh on 7/11/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var mainButton: UIButton!
    var controller: UIViewController?
    var indexPathItem:Int?
    @IBAction func buttonPushed(_ sender: UIButton) {
        print("You are trying to look into this dog!")
        if let vc = controller as? ViewController{
            vc.performSegue(withIdentifier: "EditSegue", sender: indexPathItem)
        }
    }
}
