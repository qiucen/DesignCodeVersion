//
//  QCHomeDetailView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK:  - 提取独立视图
struct QCHomeDetailView: View {
    @Binding var isShowProfile: Bool
    var body: some View {
        VStack {
            HStack {
                Text("观看视频") // 标题文本
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                AvatarButtonView(isShowProfile: $isShowProfile) // 此处传递绑定状态，绑定用于组件之间的通信
            }
            .padding(.horizontal) // 水平填充
            .padding(.top, 30) // 顶部填充
            Spacer()
        }
    }
}

struct QCHomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QCHomeDetailView(isShowProfile: .constant(false)) // 这里的预览视图传递 .constant(false)
        // 是因为，没有可以传递的绑定值，所以传默认值
    }
}
