//
//  QCButtons.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/2.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK: - 双重 shadow 按钮
struct QCButtons: View {
    var body: some View {
        VStack { // 嵌入父容器
            Text("按钮")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background( // 这个括号里面的代码是做内置阴影，内置阴影的基本思路就是：在 Z 轴添加阴影
                    ZStack {
                        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous) // 设置圆角矩形
                            .foregroundColor(.white) // 前景色
                            .blur(radius: 4) // 模糊
                            .offset(x: -8, y: -8) // 偏移
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous) // 设置圆角矩形
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color.white]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)) // 线性填充
                        .padding(2) // 填充是为了让边距显示出来
                        .blur(radius: 2) // 模糊
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous)) // 裁剪：圆角矩形
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20) // 右下阴影
                .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20) // 左上阴影
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 父容器大小
        .background(Color(#colorLiteral(red: 0.839659512, green: 0.8398010135, blue: 0.8396407962, alpha: 0.558868838))) // 背景色
        .edgesIgnoringSafeArea(.all)
    }
}

struct QCButtons_Previews: PreviewProvider {
    static var previews: some View {
        QCButtons()
    }
}
