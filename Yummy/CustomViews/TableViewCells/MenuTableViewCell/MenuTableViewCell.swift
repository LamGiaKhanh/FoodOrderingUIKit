//
//  MenuTableViewCell.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 29/07/2021.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MenuTableViewCell.self)

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupMenu(image: UIImage, title: String) {
        itemImageView.image = image
        itemTitle.text = title
    }
   
    
}
