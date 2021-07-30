//
//  FirebaseManager.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 28/07/2021.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase


struct Firebase {
    private static let storageUrl = "gs://food-ordering-f71b9.appspot.com/"
    private static let dishChild = "Dish"
    
    static let idLength = 8
    
    static let dishReference = Database.database().reference().child(dishChild)
    static let storageReference = Storage.storage().reference(forURL: storageUrl)

}

class FirebaseManager {
    func uploadDish(dish: Dish, image: UIImage, completionHandler: @escaping (CommonError?) -> Void) {
        let storageRef = Firebase.storageReference.child(dish.id ?? "")
        let metadata = StorageMetadata()
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            metadata.contentType = "image/jpg"
            print(metadata)
            print(imageData)
            //upload image
            storageRef.putData(imageData, metadata: metadata) { StorageMetadata, error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completionHandler(CommonError(error))
                    return
                    
                }
                else {
                    storageRef.downloadURL { url, error in
                        if let metaImageUrl = url?.absoluteString {
                            let dict: Dictionary<String, Any> = [
                                "id" : dish.id ?? "",
                                "name" : dish.name ?? "",
                                "description" : dish.description ?? "",
                                "cost" : dish.cost ?? 0,
                                "tag" : dish.tag ?? "",
                                "image" : metaImageUrl
                            ]
                            Firebase.dishReference.child(dish.name ?? "").updateChildValues(dict) { error, ref in
                                if error == nil {
                                    print("Uploaded dish")
                                    completionHandler(nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchAllDish(completionHandler: @escaping ([Dish]) -> Void) {
        var dishes = [Dish]()
        Firebase.dishReference.queryLimited(toLast: 1000).observeSingleEvent(of: .value,with: { (snapshot) in
            if let data = snapshot.value as? [String:Any] {
                let dataArray = Array(data)
                let values = dataArray.map {$0.1}
                for dict in values {
                    let item = dict as! NSDictionary
                    guard let id = item["id"] as? String,
                          let name = item["name"] as? String,
                          let description = item["description"] as? String,
                          let image = item["image"] as? String,
                          let cost = item["cost"] as? String,
                          let tag = item["tag"] as? String
                    else {
                        print("Error at get dishes")
                        continue
                    }
                    let dish = Dish(id: id, name: name, description: description, image: image, cost: cost, tag: tag)
                    dishes.append(dish)
                }
            }
            completionHandler(dishes)
        }) { (error) in
                print(error.localizedDescription)
                completionHandler(dishes)
        }
        
        }
        
    func fetchDishWithTag(tag: String,completionHandler: @escaping ([Dish]) -> Void) {
        var dishes = [Dish]()
        Firebase.dishReference.queryLimited(toLast: 1000).observeSingleEvent(of: .value,with: { (snapshot) in
            if let data = snapshot.value as? [String:Any] {
                let dataArray = Array(data)
                let values = dataArray.map {$0.1}
                for dict in values {
                    let item = dict as! NSDictionary
                    if let tagValue = item["tag"] as? String
                    {
                        if ((tagValue.contains(tag))) {
                            guard let id = item["id"] as? String,
                                  let name = item["name"] as? String,
                                  let description = item["description"] as? String,
                                  let image = item["image"] as? String,
                                  let cost = item["cost"] as? String,
                                  let tag = item["tag"] as? String
                            else {
                                print("Error at get dishes")
                                continue
                            }
                        
                            let dish = Dish(id: id, name: name, description: description, image: image, cost: cost, tag: tag)
                            dishes.append(dish)
                        }
                    }
                }
            }
            completionHandler(dishes)
        }) { (error) in
                print(error.localizedDescription)
                completionHandler(dishes)
        
        }
    }
}
