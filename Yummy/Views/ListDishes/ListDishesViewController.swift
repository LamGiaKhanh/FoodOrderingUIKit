//
//  ListDishesViewController.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ListDishesViewController: UIViewController {

    var category: DishCategory!
    @IBOutlet weak var listDishesTableView: UITableView!
    var transparentView = UIView()
    var addDetailView = AddDetailView()
    
    private var listDishViewModel = DishViewModel()
    private var dishes : [Dish] = []
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
        bindDishesData()
        // Do any additional setup after loading the view.
    }
    
    private func registerCells() {
        listDishesTableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    private func bindDishesData() {
        listDishViewModel.items.bind(to: listDishesTableView.rx.items(cellIdentifier: DishListTableViewCell.identifier, cellType: DishListTableViewCell.self)) {
            row,model,cell in
            cell.setup(dish: model)
            cell.currentDish = model
            cell.delegate = self
        }.disposed(by: bag)
        
        listDishesTableView.rx.modelSelected(Dish.self).bind { dish in
            let controller = DishDetailViewController.instantiate()
            controller.dish = dish
            self.navigationController?.pushViewController(controller, animated: true)
        }
        if let tag = category.name {
            listDishViewModel.FetchDishWithTag(tag: tag.lowercased())
        }
        
    }
}

extension ListDishesViewController: DishListTableViewCellDelegate {
    
    func didAddedItem(item: Dish) {
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        
        let screenSize = UIScreen.main.bounds.size
        addDetailView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height/4)
        addDetailView.dish = item
        addDetailView.populateView()
        window?.addSubview(addDetailView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut,animations: {
            self.transparentView.alpha = 0.5
            self.addDetailView.frame = CGRect(x: 0, y: screenSize.height * 3/4, width: screenSize.width, height: screenSize.height/4)
        },completion: nil)
        
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut,animations: {
            self.transparentView.alpha = 0
            self.addDetailView.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: screenSize.height * 3/4)
        }, completion: nil)
    }
    
    
}
