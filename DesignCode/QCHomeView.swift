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
    /// `是否显示内容 - 默认不显示`
    @State var isShowContent = false
    @EnvironmentObject var user: QCUserStore
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all) // 忽略安全区域
            
            QCHomeBackgroundView(isShowProfile: $isShowProfile) // 背景视图
                .offset(y: isShowProfile ? -450 : 0) // 设置偏移量
                .rotation3DEffect(.degrees(isShowProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0)) // 设置 3d 旋转效果
                              // 这里的 Double(viewState.height / 10) - 10 是为了不让动画这么锐利，看起来更平滑一点
                .scaleEffect(isShowProfile ? 0.9 : 1) // 设置缩放
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 设置动画
                .edgesIgnoringSafeArea(.all)
            
            QCHomeDetailView(isShowProfile: $isShowProfile, isShowContent: $isShowContent, viewState: $viewState) // 提取视图到一个单独的文件
                
            
            QCMenuView(isShowProfile: $isShowProfile) // 菜单视图
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
            
            if user.showLogin {
                ZStack {
                    QCLoginView()
                    
                    QCDismissButton()
                        .padding()
                        .onTapGesture {
                            self.user.showLogin = false
                    }
                }
            }
            
            if isShowContent { // 改变状态，显示视图
                QCBlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                QCContentView()
                QCDismissButton() // 堆叠顺序： 关闭按钮应该在内容视图之上，否则不能交互
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                    .onTapGesture {
                        self.isShowContent = false
                }
            }
        }
    }
}

// MARK: - 预览
struct QCHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QCHomeView()
//            .environment(\.colorScheme, .dark) // 设置 `暗黑模式` 下预览
//            .environment(\.sizeCategory, .extraExtraLarge) // 设置 `超超大字体预览`
            .environmentObject(QCUserStore())
    }
}

// MARK: - 用户头像视图
struct AvatarButtonView: View {
    @Binding var isShowProfile: Bool // 声明绑定状态 - 此处用来接收
    @EnvironmentObject var user: QCUserStore // 声明用户是否登录环境
    
    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: { self.isShowProfile.toggle() }) { // 头像按钮
                Image("Illustration5")
                    .renderingMode(.original) // 原色模式
                    .resizable() // 可调整尺寸
                    .frame(width: kButtonWidth, height: kButtonWidth) // 尺寸
                }
            } else {
                Button(action: { self.user.showLogin.toggle() }) { // 头像按钮
                Image(systemName: "person")
                    .foregroundColor(Color.primary) // 设置文字颜色 .primary 适合自适应暗黑模式文字颜色
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("icons"))
                    .clipShape(Circle())
                    .modifier(QCShadow(
                        shadowOpacity1: 0.1, shadowRadius1: 1, // 第一重投影
                        shadowOpacity2: 0.2, shadowRadius2: 5)) // 第二重投影
                }
            }
        }
    }
}

// MARK: - 关闭按钮
struct QCDismissButton: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .frame(width: kButtonWidth, height: kButtonWidth)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(Circle())
            }
            Spacer()
        }
        .offset(x: -16, y: 16)
    }
}

// MARK: - 背景视图
struct QCHomeBackgroundView: View {
    @Binding var isShowProfile: Bool // 绑定状态
    var body: some View {
        VStack { // 在设置渐变的地方，设置暗黑模式的背景颜色
            LinearGradient(gradient: Gradient(colors: [Color("background"), Color("background")]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(Color("background"))
        // 设置圆角裁剪
            .clipShape(RoundedRectangle(cornerRadius: isShowProfile ? 30 : 0, style: .continuous))
        // 设置阴影
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
