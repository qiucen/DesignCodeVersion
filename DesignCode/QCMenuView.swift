//
//  QCMenuView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/26.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `图像宽高`
private let kIconWidth: CGFloat = 32
/// `字体大小`
private let kFontSize: CGFloat = 20
/// `文本框宽度`
private let kTextWidth: CGFloat = 120
/// `整个菜单控件高度`
private let kMenuHeight :CGFloat = 300
/// `半径`
private let kRaduis: CGFloat = 30

struct QCMenuView: View {
    var body: some View {
        
        VStack {
            // 这里将整个菜单控件填入一个垂直容器中，在顶部添加弹簧，将视图推向底部
            Spacer() // 弹簧
            VStack(spacing: 16) {
                QCMenuRow(titile: "账  户", icon: "gear")
                QCMenuRow(titile: "账  单", icon: "creditcard")
                QCMenuRow(titile: "我  的", icon: "person.crop.circle")
            }
                .frame(maxWidth: .infinity) // 最大宽度为屏幕宽度 - 注意这里一定要用 maxWidth:
                .frame(height: kMenuHeight) // 整个菜单控件的高度
                .background(Color.white) // 背景颜色
                .clipShape(RoundedRectangle(cornerRadius: kRaduis, style: .continuous)) // 圆角裁剪
                .shadow(radius: kRaduis) // 阴影
                .padding(.horizontal, kRaduis) // 水平填充
        }
        .padding(.bottom, kRaduis) // 底部填充
    }
}

struct QCMenuView_Previews: PreviewProvider {
    static var previews: some View {
        QCMenuView()
    }
}

// MARK: - 菜单：每行
struct QCMenuRow: View {
    
    var titile: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) { // 设置间距为 16
            // 设置图像 - 默认图像可以使用 .font 属性设置
            Image(systemName: icon)
                .font(.system(size: kFontSize, weight: .bold, design: .default)) // 设置系统图像属性
                .imageScale(.large) // 设置图像比例
                .frame(width: kIconWidth, height: kIconWidth)
            
            // 设置 Label
            Text(titile)
                .font(.system(size: kFontSize, weight: .bold, design: .default)) // 设置字体
                .frame(width: kTextWidth, alignment: .leading) // 设置文本框尺寸以及对齐方式
        }
    }
}
