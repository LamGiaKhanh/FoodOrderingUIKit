//
//  AddNewDishViewController.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 28/07/2021.
//

import UIKit
import ProgressHUD


class AddNewDishViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imagePicker = UIImagePickerController()
    let firebase = FirebaseManager()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImageBtnClicked() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func addDishBtnClicked(_ sender: UIButton) {
        addDish()

    }
    
    private func addDish() {
        ProgressHUD.show()
        if let image = dishImageView.image, nameTextField.text != "" {
            let id = randomString(length: Firebase.idLength)
            let newDish = Dish(id: id, name: nameTextField.text, description: descriptionTextField.text, cost: costTextField.text, tag: tagTextField.text)
            firebase.uploadDish(dish: newDish, image: image) { (error) in
                if error == nil {
                    ProgressHUD.showSuccess("Your dish has been added")
                    print("Dish has been added")
                }
                else {
                    print(error?.localizedDescription)
                }
                

            }
            
        }
        func clearData() {
            nameTextField.text = ""
            descriptionTextField.text = ""
            costTextField.text = ""
            tagTextField.text = ""
            dishImageView.image = #imageLiteral(resourceName: "emptyImage")

        }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    

}

extension AddNewDishViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            dishImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
