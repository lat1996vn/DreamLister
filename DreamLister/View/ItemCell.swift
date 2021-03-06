//
//  ItemCell.swift
//  DreamLister
//
//  Created by LTT on 8/6/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    func configureCell(item: Item) {
        lblTitle.text = item.title
        lblPrice.text = "$ \(item.price)"
        lblDescription.text = item.details
        if item.toImage == nil {
            imgThumb.image = UIImage(named: "addPhoto")
        } else {
            imgThumb.image = item.toImage!.image as? UIImage
        }
    }
    
}
