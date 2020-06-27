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
            .padding(.leading, 14) // 单独设置左边填充
            .padding(.top, 30) // 顶部填充
            
            ScrollView(.horizontal, showsIndicators: false) { // 创建使用 ScrollView
                HStack { // 如果要水平滑动，需要将内容放进 HStack 中
                    ForEach(0 ..< 5) { item in // 循环创建
                        SectionView()
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
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

struct SectionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("SwiftUI 中先进的原型设计")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image("Logo")
            }
            Text("18 节课")
                .frame(maxWidth: .infinity, alignment: .leading)
            Image("Illustration1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(Color("background9"))
        .cornerRadius(30)
        .shadow(color: Color("background9").opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
