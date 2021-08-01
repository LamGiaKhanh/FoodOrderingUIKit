//
//  DishPortraitCollectionViewCell.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 22/07/2021.
//

import UIKit
import Kingfisher

class DishPortraitCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: DishPortraitCollectionViewCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        titleLbl?.text = dish.name
        dishImageView?.kf.setImage(with: dish.image?.asUrl)
        costLbl?.text = dish.formattedVND()
        descriptionLbl?.text = dish.description
    }

}
