//
//  ShowViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift
import RealmSwift

class ShowViewController: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    
    var file: File!
    
    @IBOutlet weak var showTitle: UILabel!
    
    var writenLabel = ""
    
    
    @IBOutlet weak var showText: UILabel!
    
    var contents:[File] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let img = UIImage(data: file.image)
        showImage.image = img
    
        showImage.contentMode = UIView.ContentMode.scaleAspectFit
        
        showTitle.text = file.title
        
        showTitle.contentMode = UIView.ContentMode.scaleAspectFit
        
        showText.text = file.content
        
        showTitle.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    
    @IBAction func didDelete(_ sender: UIButton) {
//        realmに繋いでデータ消す
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(file)
        }
        
       navigationController?.popViewController(animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

