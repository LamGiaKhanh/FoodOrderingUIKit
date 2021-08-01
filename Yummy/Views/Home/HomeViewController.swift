//
//  HomeViewController.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 22/07/2021.
//

import UIKit
import ProgressHUD
import SideMenu
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, MenuControllerDelegate {
   
    let firebase = FirebaseManager()

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialCollectionView: UICollectionView!
    
    private var sideMenu: SideMenuNavigationController?
    private var addNewDishController = AddNewDishViewController()
    
    var categories: [DishCategory] = []
    var populars : [Dish] = []
    var specials : [Dish] = []
    
    private var popularViewModel = DishViewModel()
    private var specialViewModel = DishViewModel()
    private var categoryViewModel = DishCategoryViewModel()
    
    private var bag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        ProgressHUD.show()

        registerCells()
        setupSideMenu()
        bindPopularData()
        bindSpecialData()
        bindCategoryData()
        ProgressHUD.dismiss()
        
    }
    
    
    @IBAction func menuClicked(_ sender: Any) {
        present(sideMenu!, animated: true, completion: nil)
    }


    
    func didSelectMenuItem(name: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        switch name {
        case .addNewDish:
            let controller = AddNewDishViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        case .addNewCategory:
            let controller = AddNewCategoryViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    private func bindPopularData() {
        popularViewModel.items.bind(to: popularCollectionView.rx.items(cellIdentifier: DishPortraitCollectionViewCell.identifier, cellType: DishPortraitCollectionViewCell.self)) { row,model,cell in
                cell.setup(dish: model)
        }.disposed(by: bag)
        
        popularCollectionView.rx.modelSelected(Dish.self).bind { dish in
            let controller = DishDetailViewController.instantiate()
            controller.dish = dish
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        popularViewModel.FetchDishWithTag(tag: "popular")
        
    }
    
    func bindSpecialData() {
        specialViewModel.items.bind(to: specialCollectionView.rx.items(cellIdentifier: DishLandscapeCollectionViewCell.identifier, cellType: DishLandscapeCollectionViewCell.self)) { row,model,cell in
                cell.setup(dish: model)
                        
        }.disposed(by: bag)
        
        specialCollectionView.rx.modelSelected(Dish.self).bind { dish in
            let controller = DishDetailViewController.instantiate()
            controller.dish = dish
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        specialViewModel.FetchDishWithTag(tag: "special")
    }
    
    func bindCategoryData() {
        categoryViewModel.items.bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionViewCell.identifier, cellType: CategoryCollectionViewCell.self)) {
            row,model,cell in
            cell.setup(category: model)
        }.disposed(by: bag)
        
        categoryCollectionView.rx.modelSelected(DishCategory.self).bind { category in
            let controller = ListDishesViewController.instantiate()
            controller.category = category
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        categoryViewModel.fetchCategory()
    }
    
    private func reloadData() {
        self.specialCollectionView.reloadData()
        self.popularCollectionView.reloadData()
        self.categoryCollectionView.reloadData()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
    
    private func setupSideMenu() {
        let menu = MenuTableViewController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu )
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
   }

}

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case categoryCollectionView:
//            return categories.count
//        case popularCollectionView:
//            return populars.count
//        case specialCollectionView:
//            return specials.count
//        default:
//            return 0
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView {
//        case categoryCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
//            cell.setup(category: categories[indexPath.row])
//            return cell
//        case popularCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
//            cell.setup(dish: populars[indexPath.row])
//            return cell
//        case specialCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
//            cell.setup(dish: specials[indexPath.row])
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == categoryCollectionView {
//            let controller = ListDishesViewController.instantiate()
//            controller.category = categories[indexPath.row]
//            navigationController?.pushViewController(controller, animated: true)
//        } else {
//            let controller = DishDetailViewController.instantiate()
//            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
//            navigationController?.pushViewController(controller, animated: true)
//        }
//    }
//    
//}
