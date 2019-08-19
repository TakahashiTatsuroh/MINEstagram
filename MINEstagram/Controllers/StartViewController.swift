//
//  StartViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/08/01.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import RevealingSplashView

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "cel")!,iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red: 52, green: 119, blue: 57, alpha: 1))
        
        revealingSplashView.animationType = .woobleAndZoomOut
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            self.performSegue(withIdentifier: "toHome", sender: nil)

        }
    }

}
