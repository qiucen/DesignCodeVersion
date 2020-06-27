//
//  QCHomeView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI


/// `按钮宽高`
private let kButtonWidth: CGFloat = 36

struct QCHomeView: View {
    
    /// `是否显示详情 - 默认不显示`
    @State var isShowProfile = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all) // 忽略安全区域
            VStack {
                HStack {
                    Text("观看视频") // 标题文本
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Button(action: { self.isShowProfile.toggle() }) { // 头像按钮
                        Image("Illustration5")
                            .renderingMode(.original) // 原色模式
                            .resizable() // 可调整尺寸
                            .frame(width: kButtonWidth, height: kButtonWidth) // 尺寸
                    }
                }
                .padding(.horizontal) // 水平填充
                .padding(.top, 30) // 顶部填充
                Spacer()
            }
                .padding(.top, 44) // 手动设置顶部填充状态栏高度
                .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))) // 设置背景颜色
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 设置圆角裁剪
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20) // 设置阴影
                .offset(y: isShowProfile ? -450 : 0) // 设置偏移量
                .rotation3DEffect(.degrees(isShowProfile ? -10 : 0), axis: (x: 10, y: 0, z: 0)) // 设置 3d 旋转效果
                .scaleEffect(isShowProfile ? 0.9 : 1) // 设置缩放
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 设置动画
                .edgesIgnoringSafeArea(.all) // 忽略安全区域
            
            QCMenuView() // 菜单视图
                .offset(y: isShowProfile ? 0 : 600) // 设置按钮点按偏移
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 设置动画
        }
    }
}

struct QCHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QCHomeView()
    }
}
