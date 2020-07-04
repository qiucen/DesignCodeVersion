//
//  QCSuccessView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/4.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `登录过程动画`
struct QCSuccessView: View {
    
    @State var isShow = false // 标记状态
    
    var body: some View {
        VStack { // 父容器
            Text("疯狂加载中...")
                .font(.title).bold()
                .opacity(isShow ? 1 : 0) // 通过状态改变透明度
                .animation(Animation.linear(duration: 1).delay(0.2)) // 延迟动画效果
            
            QCLottieView(fileName: "success")
                .frame(width: 300, height: 300)
                .opacity(isShow ? 1 : 0) // 通过状态改变透明度
                .animation(Animation.linear(duration: 1).delay(0.4)) // 延迟动画效果
        }
        .padding(.top, 30)
        .background(QCBlurView(style: .systemMaterial)) // 模糊背景
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 圆角矩形
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30) // 阴影
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // 动画效果
        .scaleEffect(isShow ? 1 : 0.5) // 缩放
        .onAppear {
            self.isShow = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 设置最大尺寸
        .background(Color.black.opacity(isShow ? 0.5 : 0)) // 背景透明
        .animation(.linear(duration: 0.5)) // 线性动画
        .edgesIgnoringSafeArea(.all)
    }
}

struct QCSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        QCSuccessView()
    }
}
