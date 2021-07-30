//
//  DishDetailViewController.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()

        // Do any additional setup after loading the view.
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        costLbl.text = dish.formattedVND()
    }
    
    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),!name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return
        }
        ProgressHUD.show("Placing Order...")
        Service.shared.placeOrder(dishId: dish.id ?? "", name: name) {(result) in
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Your order has been received 👨🏻‍🍳")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription + name)
            }
        }
    }
    
    

}
