//
//  MakeViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift
import RealmSwift

class MakeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    var file: File? = nil
    
    @IBOutlet weak var textView: UITextView!
    
//    var textVFile: File? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    @IBAction func runCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
        } else {
            print("カメラが使用できません")
        }
    }
    
    @IBAction func showAlbum(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("フォトライブラリが使用できません")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createNewFile(_ text: String, _ content: String) {
        
        let realm = try! Realm()
        
        let file = File()
        
        
        let id = getMaxId()
        
        file.id = id
        file.title = text
        file.content = content
        file.image = (imageView.image?.jpegData(compressionQuality: 0.1))!
        
        try! realm.write {
            realm.add(file)
        }
    }
    
    @IBAction func didSaveButton(_ sender: UIButton) {
        
        guard let text = textField.text else {
            return
        }
        
        if text.isEmpty {
            return
        }
        
        guard let content = textView.text else {
            return
        }
        
        if content.isEmpty {
            return
        }
        
        createNewFile(text,content)
        
        navigationController?.popViewController(animated: true)
    }
    
    func getMaxId() -> Int {
        let realm = try! Realm()
        
        let id = realm.objects(File.self).max(ofProperty: "id") as Int?
        
        if id == nil {
            //            最大IDがnil場合、１返す
            return 1
        } else {
            //            最大IDが存在、最大ID + 1返す
            return id! + 1
        }
        
    }
    
}


@IBDesignable class InspectableTextView: UITextView {
    
    @IBInspectable var localizedString: String = "" {
        didSet {
            guard !localizedString.isEmpty else { return }
            
            placeholderLabel.text = NSLocalizedString(localizedString, comment: "")
            placeholderLabel.sizeToFit()
        }
    }
    
//    ラベルを作成
    private lazy var placeholderLabel = UILabel(frame: CGRect(x: 6, y: 6, width: 0, height: 0))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        configurePlaceholder()
        togglePlaceholder()
    }
    
    
    private func configurePlaceholder() {
        placeholderLabel.textColor = UIColor.gray
        addSubview(placeholderLabel)
    }
    
    
    private func togglePlaceholder() {
        
        placeholderLabel.isHidden = text.isEmpty ? false : true
    }
}


extension InspectableTextView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        togglePlaceholder()
    }
}
