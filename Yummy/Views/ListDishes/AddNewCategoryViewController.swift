//
//  AddNewCategoryViewController.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 31/07/2021.
//

import UIKit
import ProgressHUD

class AddNewCategoryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryImageView: UIImageView!
    
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
    
    
    @IBAction func addCategoryBtnClicked(_ sender: UIButton) {
        addCategory()
    }
    private func addCategory() {
        ProgressHUD.show()
        if let image = categoryImageView.image, nameTextField.text != "" {
            let id = firebase.randomString(length: Firebase.idLength)
            let newCategory = DishCategory(id: id, name: nameTextField.text)
            firebase.uploadCategory(category: newCategory, image: image) { error in
                if error == nil {
                    ProgressHUD.showSuccess("New category has been added")
                    self.clearData()
                }
                else {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
    
    func clearData() {
        nameTextField.text = ""
        categoryImageView.image = UIImage()
    }
   

}


extension AddNewCategoryViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            categoryImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
