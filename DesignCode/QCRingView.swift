//
//  QCRingView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/28.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `圆环尺寸`
private let kRingWidth: CGFloat = 44
/// `旋转角度`
private let kRotationDegrees: Double = 90
private let kLineWidth: CGFloat = 5

/// `进度视图`
struct QCRingView: View {
    var body: some View {
        ZStack { // 背景父容器，容器内部子视图的顺序是： 代码写最上面的，子视图在最里面
            
            Circle() // 背景圆环
                .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: kLineWidth)) // 设置填充
                .frame(width: kRingWidth, height: kRingWidth) // 设置尺寸
            
            Circle() // 进度圆环
                .trim(from: 0.2, to: 1) // 剪切，默认 3点钟方向是起点，终点是(1 - 0.1) = 0.9 的位置
                .stroke( // 渲染
                    LinearGradient( // 渐变
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), // 渐变颜色数组
                        startPoint: .topTrailing, // 渲染开始位置
                        endPoint: .bottomLeading), // 渲染结束位置
                    style: StrokeStyle( // 渲染模式
                        lineWidth: kLineWidth, // 线宽
                        lineCap: .round, // 线的样式
                        lineJoin: .round, // 连接处样式
                        miterLimit: .infinity, // 转角限量(最大斜接长度)
                        dash: [20, 0], // 如果[20, 20] 那么就会生成虚框
                        dashPhase: 0))
                .rotationEffect(.degrees(kRotationDegrees)) // 旋转
                .rotation3DEffect(.degrees(kRotationDegrees * 2), axis: (x: 1, y: 0, z: 0)) // 3d 旋转 180度
                                                                             // 两次旋转之后，起点就位于 12点方向
                .frame(width: kRingWidth, height: kRingWidth) // 设置尺寸
                .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.2), radius: 3, x: 0, y: 3) // 设置阴影
            
            Text("82%")
                .font(.subheadline) // 设置字体
                .fontWeight(.bold) // 设置字号
        }
    }
}

struct QCRingView_Previews: PreviewProvider {
    static var previews: some View {
        QCRingView()
    }
}
