//
//  QCPostList.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/30.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCPostList: View {
    
    @State var posts: [QCPost] = [] // 存储的数组
    
    var body: some View {
        List(posts) { post in
            Text(post.title)
        }
        .onAppear {
            QCApiNetworkTool.shared.networkGetPost([QCPost].self) { (posts, _, error) in
                if error != nil {
                    printQCDebug(message: error)
                    return
                }
                self.posts = posts as! [QCPost]
            }
        }
    }
}

struct QCPostList_Previews: PreviewProvider {
    static var previews: some View {
        QCPostList()
    }
}
