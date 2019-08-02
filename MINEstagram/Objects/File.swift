//
//  File.swift
//  MINEstagram
//
//  Created by 高橋達朗 on 2019/07/31.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import RealmSwift

class File: Object {
    
    @objc dynamic var id: Int = 0
    
    @objc dynamic var title: String = ""
    
    @objc dynamic var content: String = ""
    
    @objc dynamic var image: Data = Data()
    
}
