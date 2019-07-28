//
//  ViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didAdttionButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toMake", sender: nil)
    }
    
}



