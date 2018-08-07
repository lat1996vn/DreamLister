//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by LTT on 8/7/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tfTitle: CustomTextField!
    @IBOutlet weak var tfPrice: CustomTextField!
    @IBOutlet weak var tfDetails: CustomTextField!
    
    var stores = [Store]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if stores.isEmpty {
            generateTestData()
        }
        getStores()
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
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
        } catch {
            //handle the error
        }
    }
    
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
