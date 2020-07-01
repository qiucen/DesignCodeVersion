//
//  QCTabBarView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCTabBarView: View {
    var body: some View {
        TabView {
            QCHomeView().tabItem {
                Image(systemName: "play.circle.fill") // tabbar 图片
                Text("首页")
            }
            QCCourseListView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("证书")
            }
        }
        .accentColor(.black) // 设置 Tabbar 的 tintColor
//        .edgesIgnoringSafeArea(.top) // 忽略顶部安全区域
    }
}

// MARK: - 多设备实时预览
struct QCTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group { // 多设备实时预览
            QCTabBarView().previewDevice("iPhone 8")
            QCTabBarView().previewDevice("iPhone 11")
        }
    }
}
