//
//  QCModifiers.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/28.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK: - 分类：修饰器

/// `阴影`
struct QCShadow: ViewModifier {
    // 可以不设置默认值，不过最好还是设置默认值
    var shadowOpacity1: Double
    var shadowRadius1: CGFloat
    var shadowOpacity2: Double
    var shadowRadius2: CGFloat
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(shadowOpacity1), radius: shadowRadius1, x: 0, y: shadowRadius2)
            .shadow(color: Color.black.opacity(shadowOpacity2), radius: shadowRadius2, x: 0, y: shadowRadius2)
    }
}

/// `字体`
struct QCFont: ViewModifier {
    var style: Font.TextStyle = .body // 声明字体样式，设置默认值，外部可以传值改变
    var design: Font.Design = .default // 声明变量， 外界可以传值改变
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: design))
    }
}


// MARK: - 自定义字体
/**
 步骤：
 1. 先下载字体，将资源文件 .ttf 拖入项目中
 2. 在 info.plist 中 设置 Fonts provided by application 键，增加需要的字体名称
 3. 如下自定义
 */

enum QC_font: String {
    case semiBold = "WorkSans-SemiBold"
    case regular = "WorkSans-Regular"
    case extraBold = "WorkSans-ExtraBold"
}
struct QCCustomFont: ViewModifier {
    var font: QC_font = .semiBold
    var size: CGFloat = 28
    func body(content: Content) -> some View {
        content.font(.custom(font.rawValue, size: size))
    }
}
