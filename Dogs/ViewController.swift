//
//  ViewController.swift
//  Dogs
//
//  Created by Ashwin Mahesh on 7/11/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBAction func addPushed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddSegue", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func fetchAll(){
        let request:NSFetchRequest<Dog> = Dog.fetchRequest()
        do{
            let dogs = try context.fetch(request)
            for dog in dogs{
                print(dog.name)
            }
        }
        catch{
            print(error)
        }
    }
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue){
        let source = segue.source as! AddVC
        let newDog = Dog(context:context)
        newDog.name = source.nameField.text
        newDog.color = source.colorField.text
        newDog.treat = source.treatField.text
        let imageData = UIImagePNGRepresentation(source.uploadButton.backgroundImage(for: .normal)!)!
        newDog.image = imageData.base64EncodedString(options: .lineLength64Characters)
        appDelegate.saveContext()
        print("Dog successfully added")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

