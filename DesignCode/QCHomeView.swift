//
//  QCHomeView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `屏幕尺寸`
let kScreenRect = UIScreen.main.bounds

/// `按钮宽高`
private let kButtonWidth: CGFloat = 36

struct QCHomeView: View {
    
    /// `是否显示详情 - 默认不显示`
    @State var isShowProfile = false
    /// `初始视图状态 - .zero`
    @State var viewState: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all) // 忽略安全区域
            
            
            QCHomeDetailView(isShowProfile: $isShowProfile) // 提取视图到一个单独的文件
                .padding(.top, 44) // 手动设置顶部填充状态栏高度
                .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))) // 设置背景颜色
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 设置圆角裁剪
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20) // 设置阴影
                .offset(y: isShowProfile ? -450 : 0) // 设置偏移量
                .rotation3DEffect(.degrees(isShowProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0)) // 设置 3d 旋转效果
                              // 这里的 Double(viewState.height / 10) - 10 是为了不让动画这么锐利，看起来更平滑一点
                .scaleEffect(isShowProfile ? 0.9 : 1) // 设置缩放
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 设置动画
                .edgesIgnoringSafeArea(.all) // 忽略安全区域
            
            QCMenuView() // 菜单视图
                .background(Color.black.opacity(0.001)) // 设置透明背景视图，目的在于添加点击手势
                .offset(y: isShowProfile ? 0 : kScreenRect.height) // 设置按钮点按偏移
                .offset(y: viewState.height) // 设置拖拽手势产生的偏移，让视图移动
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 设置动画
                .onTapGesture { // 添加点击手势
                    self.isShowProfile.toggle() // 改变状态，dismiss 菜单视图
            }
                .gesture(
                    DragGesture().onChanged({ (value) in
                        self.viewState = value.translation // 存储偏移量
                    })
                        .onEnded({ (value) in
                            if self.viewState.height > 50 { // 设置偏移量改变 dismiss 视图
                                self.isShowProfile = false
                            }
                            self.viewState = .zero // 重置偏移量
                        })
            )
        }
    }
}

struct QCHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QCHomeView()
    }
}

struct AvatarButtonView: View {
    @Binding var isShowProfile: Bool // 申明绑定状态 - 此处用来接收
    var body: some View {
        Button(action: { self.isShowProfile.toggle() }) { // 头像按钮
            Image("Illustration5")
                .renderingMode(.original) // 原色模式
                .resizable() // 可调整尺寸
                .frame(width: kButtonWidth, height: kButtonWidth) // 尺寸
        }
    }
}
