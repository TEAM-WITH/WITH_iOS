//
//  MyPageModifyViewController.swift
//  With
//
//  Created by anhyunjun on 2020/01/01.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

protocol MyPageDelegate {
    func didModifyMyPage(text: String, profile: UIImage?, background: UIImage?)
    func cancelModify()
}


class MyPageModifyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: MyPageDelegate?
    var count = 0
    
    @IBOutlet weak var pressXButton: UIButton!
    @IBOutlet weak var modifyProfileButton: UIButton!
    @IBOutlet weak var modifyBackgroundButton: UIButton!
    @IBOutlet weak var modifyProfileImageButton: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var myPageLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    var defaultProfileImg: UIImage!
    var defaultProfileText: String!
    var defaultBackgroundImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPageLabel.isHidden = true
        profileImg.image = defaultProfileImg
        backgroundImg.image = defaultBackgroundImg
        commentTextField.text = defaultProfileText
         self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
        
    }
    @IBAction func pressXButton(_ sender: Any) {
        delegate?.cancelModify()
        myPageLabel.isHidden = false
        modifyProfileButton.isHidden = false
        self.dismiss(animated: true)
        
    }
    @IBAction func saveButton(_ sender: Any) {
        let text = commentTextField.text ?? ""
        let profileImg = self.profileImg.image 
        let backgroundImg = self.backgroundImg.image
        delegate?.didModifyMyPage(text: text, profile: profileImg, background: backgroundImg)
        myPageLabel.isHidden = true
        self.dismiss(animated: true)
        
    }
    
    @IBAction func editBackgroundImg(_ sender: Any) {
        let backgroundPicker = UIImagePickerController()
        backgroundPicker.delegate = self
        backgroundPicker.sourceType = .photoLibrary
        self.present(backgroundPicker, animated: true, completion: nil)
        
        if((modifyBackgroundButton) != nil){
            count = 1
        }
    }
    
    @IBAction func editProfileImg(_ sender: Any) {
        let profilePicker = UIImagePickerController()
             profilePicker.delegate = self
             profilePicker.sourceType = .photoLibrary
             self.present(profilePicker, animated: true, completion: nil)
        if((modifyProfileImageButton) != nil){
                   count = 2
               }
        
    }
    func imagePickerController (_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if count == 1{
            self.backgroundImg.image = image
            }else if count == 2 {
            self.profileImg.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
}
