//
//  DishListTableViewCell.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import UIKit
import Kingfisher

protocol DishListTableViewCellDelegate {
    func didAddedItem(item: Dish)
}

class DishListTableViewCell: UITableViewCell {
    
    var delegate: DishListTableViewCellDelegate?
    static let identifier = String(describing: DishListTableViewCell.self)
    var added = false { didSet
    {
        addButton.isHidden = added
    }
        
    }
    var currentDish: Dish!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.formattedVND()
    }
    
    func setup(order: Order) {
//        dishImageView.kf.setImage(with: order.detail?.image?.asUrl)
//        titleLbl.text = order.dish?.name
//        descriptionLbl.text = order.dish?.description
    }
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let selectedDish = Dish(name: currentDish.name, image: currentDish.image, cost: currentDish.cost)
        delegate?.didAddedItem(item: selectedDish)
    }
}
