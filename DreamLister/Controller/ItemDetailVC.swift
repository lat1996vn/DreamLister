//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by LTT on 8/7/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tfTitle: CustomTextField!
    @IBOutlet weak var tfPrice: CustomTextField!
    @IBOutlet weak var tfDetails: CustomTextField!
    @IBOutlet weak var thumgImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStores()
        loadItemData()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when select
    }
    
    // Save the editing or create new item
    @IBAction func btnSavePressed(_ sender: Any) {
        var item: Item!
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        var image: Image!
        if item.toImage == nil {
            image = Image(context: context)
            item.toImage = image
        } else {
            image = item.toImage
        }
        image.image = thumgImage.image
        
        
        if let title = tfTitle.text {
            item.title = title
        }
        if let price = tfPrice.text as NSString? {
            item.price = price.doubleValue
        }
        if let details = tfDetails.text {
            item.details = details
        }
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        appDel.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Delete item
    @IBAction func btnDeletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            appDel.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Add to image by UIImagePickerController
    @IBAction func btnAddPhoto(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
                thumgImage.image = img
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Load item data to ItemDetailVC
    func loadItemData() {
        if let item = itemToEdit {
            tfTitle.text = item.title
            tfPrice.text = "\(item.price)"
            tfDetails.text = item.details
            if item.toImage == nil {
                thumgImage.image = UIImage(named: "addPhoto")
            } else {
                thumgImage.image = item.toImage!.image as? UIImage
            }
            for index in 0..<self.stores.count {
                if item.toStore?.name == stores[index].name {
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                    break
                }
            }
        }
    }
    
    //get store's names to pickerView, if haven't data generate test data and reload pickerView
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            if stores.isEmpty {
                generateTestData()
                self.stores = try context.fetch(fetchRequest)
            }
            self.pickerView.reloadAllComponents()
        } catch {
            //handle the error
        }
    }
    
    //Generate test data of stores
    func generateTestData() {
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "Amazon"
        let store4 = Store(context: context)
        store4.name = "Frys Electronics"
        let store5 = Store(context: context)
        store5.name = "K Mart"
        appDel.saveContext()
    }
}
