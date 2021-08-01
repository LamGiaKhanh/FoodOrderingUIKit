//
//  AddDetailView.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 01/08/2021.
//

import UIKit
import GMStepper
import Kingfisher

class AddDetailView: UIView {


    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var amountStepper: GMStepper!
    
    var dish: Dish!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        let viewFromNib = Bundle.main.loadNibNamed("AddDetailView", owner: self, options: nil)![0] as! UIView
        viewFromNib.frame = self.bounds
        addSubview(viewFromNib)

    }
    
    func populateView() {
        titleLbl.text = dish.name
        costLbl.text = dish.formattedVND()
        dishImageView.kf.setImage(with: dish.image?.asUrl)
    }
    @IBAction func addButtonClicked(_ sender: UIButton) {
        AppDelegate.shared().sharedOrderDetail?.dishes.append(dish)
        AppDelegate.shared().sharedOrderDetail?.amount.append(Int(amountStepper.value))
        
    }
    
}
