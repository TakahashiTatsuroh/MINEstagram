//
//  ShowViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    
    var selectedImg: UIImage!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
    showImage.image = selectedImg
    
        showImage.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
