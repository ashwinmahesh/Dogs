//
//  EditVC.swift
//  Dogs
//
//  Created by Ashwin Mahesh on 7/11/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var treatField: UITextField!
    @IBOutlet weak var pictureButton: UIButton!
    
    var nameText:String?
    var colorText:String?
    var treatText:String?
    var pictureText:String?
    
    @IBAction func cancelPushed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = nameText
        colorField.text = colorText
        treatField.text = treatText
        if let decodedData = Data(base64Encoded: pictureText!, options: .ignoreUnknownCharacters){
            let decodedImage:UIImage = UIImage(data: decodedData)!
            pictureButton.setBackgroundImage(decodedImage, for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
