//
//  CategoryViewModel.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 31/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct DishCategoryViewModel {
    let firebase = FirebaseManager()
    
    var items = PublishSubject<[DishCategory]>()
    
    func fetchCategory() {
        firebase.fetchCategory { categories in
            items.onNext(categories)
            items.onCompleted()
        }
    }
    
}
