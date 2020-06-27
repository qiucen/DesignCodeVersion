//
//  QCRingView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/28.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `旋转角度`
private let kRotationDegrees: Double = 90
/// `线宽`
private let kLineWidth: CGFloat = 5

/// `进度视图`
struct QCRingView: View {
    
    var color1 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) // 渐变颜色1
    var color2 = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) // 渐变颜色2
    var ringWidth: CGFloat = 200 // 圆环宽高
    var percent: CGFloat = 88 // 进度百分比
    @Binding var isShow: Bool // 外部传值改变状态需要绑定，绑定只用指定类型不需要默认值
    
    var body: some View {
        
        // 渲染乘数，因为是在 body 内部创建，所以需要在 return 给父容器
        let mutiplier = ringWidth / 44 // 渲染乘数，所有设计到渲染的地方(线宽，阴影，字体)都应该乘上 `渲染乘数`
        let progress = 1 - percent / 100 // 进度计算公式
        
        return ZStack { // 背景父容器，容器内部子视图的顺序是： 代码写最上面的，子视图在最里面
            
            Circle() // 背景圆环
                .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: kLineWidth * mutiplier)) // 设置填充
                .frame(width: ringWidth, height: ringWidth) // 设置尺寸
            
            Circle() // 进度圆环
                .trim(from: isShow ? progress : 1, to: 1) // 剪切，默认 3点钟方向是起点，终点是(1 - 0.1) = 0.9 的位置
                .stroke( // 渲染
                    LinearGradient( // 渐变
                        gradient: Gradient(colors: [Color(color1), Color(color2)]), // 渐变颜色数组
                        startPoint: .topTrailing, // 渲染开始位置
                        endPoint: .bottomLeading), // 渲染结束位置
                    style: StrokeStyle( // 渲染模式
                        lineWidth: kLineWidth * mutiplier, // 线宽
                        lineCap: .round, // 线的样式
                        lineJoin: .round, // 连接处样式
                        miterLimit: .infinity, // 转角限量(最大斜接长度)
                        dash: [20, 0], // 如果[20, 20] 那么就会生成虚框
                        dashPhase: 0))
                .rotationEffect(.degrees(kRotationDegrees)) // 旋转
                .rotation3DEffect(.degrees(kRotationDegrees * 2), axis: (x: 1, y: 0, z: 0)) // 3d 旋转 180度
                                                                             // 两次旋转之后，起点就位于 12点方向
                .frame(width: ringWidth, height: ringWidth) // 设置尺寸
                .shadow(color: Color(color1).opacity(0.2), radius: 3 * mutiplier, x: 0, y: 3 * mutiplier) // 设置阴影
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * mutiplier)) // 设置字体
                .fontWeight(.bold) // 设置字号
                .onTapGesture {
                    self.isShow.toggle()
            }
        }
    }
}

struct QCRingView_Previews: PreviewProvider {
    static var previews: some View {
        QCRingView(isShow: .constant(true))
    }
}
