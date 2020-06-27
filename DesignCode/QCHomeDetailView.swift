//
//  QCHomeDetailView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK:  - 提取的独立视图
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
                    ForEach(sectionData) { item in // 循环创建
                        SectionView(section: item) // 填充数据
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

// MARK: - 单张课程卡片视图
struct SectionView: View {
    var section: SectionModel // 数据模型
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}


// MARK: - 基本数据模型
struct SectionModel: Identifiable {
    /// `自动生成的唯一标识符`
    var id = UUID()
    /// `标题`
    var title: String
    /// `文本内容`
    var text: String
    /// `文本字符串`
    var logo: String
    /// `图像`
    var image: Image
    /// `颜色`
    var color: Color
}


// MARK: - 样本数据
let sectionData = [
    SectionModel(title: "SwiftUI 中的原型设计", text: "18 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration1")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    SectionModel(title: "SwiftUI 创造一个app", text: "20 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))),
    SectionModel(title: "SwiftUI 的先进之处", text: "20 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration4")), color: Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))),
    SectionModel(title: "SwiftUI 可玩性很高", text: "16 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration3")), color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
]


