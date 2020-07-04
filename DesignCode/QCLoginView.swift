//
//  QCLoginView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/4.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCLoginView: View {
    
    @State var userEmail = "" // 账号
    @State var password = "" // 密码
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.edgesIgnoringSafeArea(.all) // 添加背景色
            
            Color.white // 在第一层背景色之上再添加一层背景色
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 先裁剪
                .edgesIgnoringSafeArea(.bottom) // 忽略底部安全区域
            
            QCCoverView()
            
            VStack { // 账号密码输入视图
                HStack { // 账号
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1))) // 图像前景色
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    
                    TextField("请输入账号", text: $userEmail) // placeHolder 和 绑定的文字(用户输入的)
                        .keyboardType(.emailAddress) // 只能输入 email
                        .font(.subheadline) // 字体
                        .padding(.leading) // 左边填充
                        .frame(height: 44) // 高度
                }
                
                Divider().padding(.leading, 80) // 中间分割线，填充是为了与文本对齐
                
                HStack { // 密码
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1))) // 图像前景色
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    
                    SecureField("请输入密码", text: $password) // 安全输入文本框
                        .keyboardType(.default)
                        .font(.subheadline) // 字体
                        .padding(.leading) // 左边填充
                        .frame(height: 44) // 高度
                }
            }
            .frame(height: 136)
            .frame(maxWidth: .infinity)
            .background(QCBlurView(style: .systemMaterial)) // 模糊背景
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 圆角裁剪
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20) // 阴影
            .padding(.horizontal) // 横向填充
            .offset(x: 0, y: 460) // 偏移
            
        }
    }
}

struct QCLoginView_Previews: PreviewProvider {
    static var previews: some View {
        QCLoginView()
//        .previewDevice("iPad Air 2")
    }
}


// MARK: - 顶部背景视图
struct QCCoverView: View {
    
    @State var isShow = false // 是否显示状态标记
    @State var viewState: CGSize = .zero // 存储拖拽改变值
    @State var isDragging = false // 是否拖拽状态标记
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("春天，十个海子\n在这光明的景色中")
                    .font(.system(size: geo.size.width / 10, weight: .bold))
                    // 这里设置的字体是随设备屏幕变化而变化的，但是限定了一个屏幕宽度最大值
                    .foregroundColor(.white)
            }
                .frame(maxWidth: 375, maxHeight: 100) // 多设备适配时，设置最大宽度为最小屏幕宽度
                .padding(.horizontal, 16) // 设置横向填充
                .offset(x: viewState.width / 15, y: viewState.height / 15) // 利用偏移制作出拖拽时视差效果
            
            Text("嘲笑这一野蛮而悲伤的海子\n你这么长久的沉睡是为了什么？")
                .font(.subheadline)
                .offset(x: viewState.width / 20, y: viewState.height / 20) // 利用偏移制作出拖拽时视差效果
            
            Spacer() // 这里的 Spacer 是为了将文本推上去
        }
            .multilineTextAlignment(.center) // 多行文本居中对齐
            .padding(.top, 100) // 顶部填充 100
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob")) // 深色气泡
                        .offset(x: -150, y: -200) // 在背景图片之中设置偏移，只偏移图片
                        .rotationEffect(.degrees(isShow ? 360 + 90 : 90))
                        // 360 + 90 是为了旋转时旋转整个圆
                        .blendMode(.plusDarker) // 混合模式
//                        .animation(Animation.linear(duration: 120) // 线性动画
//                            .repeatForever(autoreverses: false)) // 持续
                    .animation(nil)
                        .onAppear { self.isShow = true }
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob")) // 浅色气泡
                        .offset(x: -200, y: -250) // 在背景图片之中设置偏移，只偏移图片
                        .rotationEffect(.degrees(isShow ? 360 : 0), anchor: .leading) // 旋转
                        .blendMode(.overlay) // 混合模式
                        .animation(Animation.linear(duration: 120)
                            .repeatForever(autoreverses: false))
                }
        )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3")) // 背景图片
                    .offset(x: viewState.width / 25, y: viewState.height / 25), // 利用偏移制作出拖拽时视差效果,
                alignment: .bottom)
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1))) // 背景颜色
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 圆角裁剪
            .scaleEffect(isDragging ? 0.9 : 1) // 缩放
//            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8)) // 在 3d 旋转之前添加动画和缩放效果，才可以平滑过渡
        .animation(nil)
            .rotation3DEffect(.degrees(5), axis: (x: viewState.width, y: viewState.height, z: 0)) // 3d 旋转
            .gesture( // 创建手势
                DragGesture().onChanged({ (value) in
                    self.viewState = value.translation // 存储拖拽产生的偏移值
                    self.isDragging = true
                })
                    .onEnded({ (value) in
                        self.viewState = .zero // 拖拽结束时重置
                        self.isDragging = false
                    })
        )
    }
}
