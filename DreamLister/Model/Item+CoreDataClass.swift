//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by LTT on 8/5/18.
//  Copyright © 2018 LTT. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
