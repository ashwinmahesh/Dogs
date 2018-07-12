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
    @IBOutlet weak var collectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tableData:[Dog] = []
    
    @IBAction func addPushed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddSegue", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchAll()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPathInt = sender as? Int{
            print("Index Path Int is: ", indexPathInt)
            let dog = tableData[indexPathInt]
//            print(dog.name, dog.color, dog.treat)
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! EditVC
            dest.nameText = dog.name
            dest.colorText = dog.color
            dest.treatText = dog.treat
            dest.pictureText = dog.image
            dest.indexPathInt = indexPathInt
        }
    }
    func fetchAll(){
        let request:NSFetchRequest<Dog> = Dog.fetchRequest()
        do{
            tableData = try context.fetch(request)
            for dog in tableData{
                print(dog.name!)
                if dog.image != nil{
                    print("Dog has image")
                }
                else{
                    print("Dog does not have image")
                }
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
        tableData.append(newDog)
        collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func unwindFromEdit(segue: UIStoryboardSegue){
        print("Back from editing")
        let source = segue.source as! EditVC
        let dog = tableData[source.indexPathInt!]
        dog.name = source.nameField.text
        dog.color = source.colorField.text
        dog.treat = source.treatField.text
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! CustomCell
        print("Index path item is: \(indexPath.item)")
        cell.mainButton.setTitle(tableData[indexPath.item].name, for: .normal)
        if let decodedData = Data(base64Encoded: tableData[indexPath.item].image!, options: .ignoreUnknownCharacters){
            let decodedImage:UIImage = UIImage(data: decodedData)!
            cell.mainButton.setBackgroundImage(decodedImage, for: .normal)
        }
        cell.controller = self
        cell.indexPathItem = indexPath.item
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected this")
    }
    
}

