//
//  ViewController.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import RevealingSplashView
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var files:[File] = []
    
    var selectedImage: UIImage?
    
    func reloadCollectionView() {
        let realm = try! Realm()
        
        files = realm.objects(File.self).reversed()
        
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        reloadCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionView()
    }

    @IBAction func didAdttionButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toMake", sender: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return files.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let file = files[indexPath.row]
        
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        // 2. 表示する画像を生成する
//        let cellImage = UIImage(named: files[indexPath.row])
        let cellImage = UIImage(data: files[indexPath.row].image)
        imageView.image = cellImage
//        cell.= file.image
        
        // 3. ImageViewに生成した画像を設定する
//        cell.accessoryType = .disclosureIndicator
        
        // 取得したセルにラベルを設定する
        // 1. セルの中のLabelを取得する
        let label = cell.contentView.viewWithTag(2) as! UILabel
        // 2. 取得したLabelに文字を設定する
        label.text = "こんにちは"
        
        // 完成したセルを返却する
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImage を設定

        selectedImage = UIImage(data: files[indexPath.row].image)

   
        

        if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toShow",sender: file)
        }
        
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toShow") {
            let subVC: ShowViewController = (segue.destination as? ShowViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            subVC.selectedImg = sender as! File
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpace:CGFloat = 2
        
        let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
        
    }
    
}
