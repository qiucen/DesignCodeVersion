//
//  QCUpdateDetailView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCUpdateDetailView: View {
    var update: QCUpdateModel = updates[0] // 默认显示的数据为第一条数据
    var body: some View {
        List {
            VStack(spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(6)
//                    .padding(.leading, 10) // 因为 tableView 本来就有填充，所以不用设置填充了
            }
            .navigationBarTitle(update.title) // 设置导航栏返回按钮标题
        }
        .listStyle(PlainListStyle()) // 设置 tableView 的样式
    }
}

struct QCUpdateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QCUpdateDetailView()
    }
}
