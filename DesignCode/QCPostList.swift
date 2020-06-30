//
//  QCPostList.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/30.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCPostList: View {
    
    @ObservedObject var store = QCDataStore() // 通过 Combine 绑定了数据，初始化直接就有
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).foregroundColor(.secondary)
            }
        }
        
    }
}

struct QCPostList_Previews: PreviewProvider {
    static var previews: some View {
        QCPostList()
    }
}
