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
    
    var textFFile: File? = nil
    
    @IBOutlet weak var textView: UITextView!
    
    var textVFile: File? = nil
    

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
    
    fileprivate func createNewFile(_ text: String) {
        
        let realm = try! Realm()
        
        let file = File()
        
        
        let id = getMaxId()
        
        file.id = id
        file.title = text
        file.content = text
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
        
        createNewFile(text)
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
    
    // MARK: - プロパティ
    /// プレースホルダーに表示する文字列（ローカライズ付き）
    @IBInspectable var localizedString: String = "" {
        didSet {
            guard !localizedString.isEmpty else { return }
            // Localizable.stringsを参照する
            placeholderLabel.text = NSLocalizedString(localizedString, comment: "")
            placeholderLabel.sizeToFit()  // 省略不可
        }
    }
    
    /// プレースホルダー用ラベルを作成
    private lazy var placeholderLabel = UILabel(frame: CGRect(x: 6, y: 6, width: 0, height: 0))
    
    // MARK: - Viewライフサイクルメソッド
    /// ロード後に呼ばれる
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        configurePlaceholder()
        togglePlaceholder()
    }
    
    /// プレースホルダーを設定する
    private func configurePlaceholder() {
        placeholderLabel.textColor = UIColor.gray
        addSubview(placeholderLabel)
    }
    
    /// プレースホルダーの表示・非表示切り替え
    private func togglePlaceholder() {
        // テキスト未入力の場合のみプレースホルダーを表示する
        placeholderLabel.isHidden = text.isEmpty ? false : true
    }
}

// MARK: -  UITextView Delegate
extension InspectableTextView: UITextViewDelegate {
    /// テキストが書き換えられるたびに呼ばれる ※privateにはできない
    func textViewDidChange(_ textView: UITextView) {
        togglePlaceholder()
    }
}
