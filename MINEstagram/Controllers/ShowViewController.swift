//
//  ShowViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ShowViewController: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    
    var selectedImg: UIImage!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    showImage.image = selectedImg
    
        showImage.contentMode = UIView.ContentMode.scaleAspectFit
        
//        font1.font = UIFont.fontAwesome(ofSize: 50, style: .brands)
//        font1.text = String.fontAwesomeIcon(name:  .envira)
//        font1.textColor = .green
//
//        font2.font = UIFont.fontAwesome(ofSize: 50, style: .brands)
//        font2.text = String.fontAwesomeIcon(name:  .envira)
//        font2.textColor = .green
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
