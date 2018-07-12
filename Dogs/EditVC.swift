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
    
    let imagePicker = UIImagePickerController()
    @IBAction func pictureButtonPushed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    var indexPathInt:Int?
    var nameText:String?
    var colorText:String?
    var treatText:String?
    var pictureText:String?
    
    @IBAction func cancelPushed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePushed(_ sender: UIButton) {
        performSegue(withIdentifier: "DeleteUnwindSegue", sender: "delete")
    }
    @IBAction func savePushed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditUnwindSegue", sender: indexPathInt)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = nameText
        colorField.text = colorText
        treatField.text = treatText
        imagePicker.delegate = self
        if let decodedData = Data(base64Encoded: pictureText!, options: .ignoreUnknownCharacters){
            let decodedImage:UIImage = UIImage(data: decodedData)!
            pictureButton.setBackgroundImage(decodedImage, for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension EditVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            pictureButton.setBackgroundImage(pickedImage, for: .normal)
        }
        pictureButton.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
}
