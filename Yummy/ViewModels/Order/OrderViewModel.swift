//
//  OrderViewModel.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 31/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct OrderViewModel {
    let firebase = FirebaseManager()
    
    var items = PublishSubject<[Order]>()
    

}
