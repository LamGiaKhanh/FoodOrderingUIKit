//
//  DishViewModel.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 31/07/2021.
//

import UIKit
import RxSwift
import RxCocoa


struct DishViewModel {
    
    let firebase = FirebaseManager()
    
    var items = PublishSubject<[Dish]>()
    
    
    func fetchAllDish()
    {
        firebase.fetchAllDish { dishes in
            items.onNext(dishes)
            items.onCompleted()
        }
    }
    
    func FetchDishWithTag(tag: String) {
        firebase.fetchDishWithTag(tag: tag) { dishes in
            items.onNext(dishes)
            items.onCompleted()
        }
    }
    
}
