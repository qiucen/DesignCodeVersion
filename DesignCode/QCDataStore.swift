//
//  QCDataStore.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/30.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Combine

class QCDataStore: ObservableObject {
    
    @Published var posts: [QCPost] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        QCNetworkTool.shared.networkGetPost([QCPost].self) { (posts, _, error) in
            if error != nil { printQCDebug(message: error); return }
            self.posts = posts as! [QCPost]
        }
    }
}
