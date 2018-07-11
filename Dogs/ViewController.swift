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
    func fetchAll(){
        let request:NSFetchRequest<Dog> = Dog.fetchRequest()
        do{
//            let dogs = try context.fetch(request)
//            for dog in dogs{
//                print(dog.name)
//            }
            tableData = try context.fetch(request)
            for dog in tableData{
                print(dog.name!)
                if dog.image != nil{
                    print("Dog has image")
                }
                else{
                    print("Dog does not have image")
                }
//                print(dog.image!)
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
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return (tableData.count/2 + tableData.count%2)
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
        return tableData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! CustomCell
        print("Index path item is: \(indexPath.item)")
        cell.mainButton.setTitle(tableData[indexPath.item].name, for: .normal)
//        if let decodedData = Data(base64Encoded: tableData[indexPath.item].image!, options: NSData.Base64DecodingOptions(rawValue: 0)){
        if let decodedData = Data(base64Encoded: tableData[indexPath.item].image!, options: .ignoreUnknownCharacters){
            let decodedImage:UIImage = UIImage(data: decodedData)!
            cell.mainButton.setBackgroundImage(decodedImage, for: .normal)
            
        }
        
        
        return cell
    }
}

