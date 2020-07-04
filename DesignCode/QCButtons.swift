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
        VStack(spacing: 50) { // 嵌入父容器
            RectangleButton()
            
            CircleButton()
            
            PayButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 父容器大小
        .background(Color(#colorLiteral(red: 0.839659512, green: 0.8398010135, blue: 0.8396407962, alpha: 0.558868838))) // 背景色
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) // 添加动画效果
    }
}

struct QCButtons_Previews: PreviewProvider {
    static var previews: some View {
        QCButtons()
    }
}


// MARK: - 圆角矩形按钮
struct RectangleButton: View {
    
    @State var isTap =  false // 点击
    @State var isPress = false // 长按
    
    var body: some View {
        Text("按钮")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background( // 这个括号里面的代码是做内置阴影，内置阴影的基本思路就是：在 Z 轴添加阴影
                ZStack {
                    Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) // 长按改变
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous) // 设置圆角矩形
                        .foregroundColor(Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))) // 前景色
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
            .overlay( // 添加重叠层
                HStack { // 父容器
                    Image(systemName: "person.crop.circle") // 头像图片, 长按扁成一条线
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color.white.opacity(isPress ? 0 : 1)) // 改变不透明度
                        .frame(width:isPress ? 58 : 54, height:isPress ? 4 : 50) // 改变大小
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), radius: 6, x: 6, y: 6)
                        .offset(x:isPress ? 70 : -10, y:isPress ? 16 : 0) // 改变偏移
                    
                    Spacer()
                }
        )
            .shadow(color: Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20) // 右下阴影
            .shadow(color: Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20) // 左上阴影
            .scaleEffect(isTap ? 1.2 : 1.0) // 点击缩放效果
            .gesture( // 长按手势
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged({ (value) in
                    self.isTap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isTap = false
                    }
                })
                    .onEnded({ (value) in
                        self.isPress.toggle()
                    })
        )
    }
}


// MARK: - 圆形按钮
struct CircleButton: View {
    
    @State var isTap = false
    @State var isPress = false
    
    var body: some View {
        ZStack { // 用 Z 轴，堆叠两个，长按进行变换
            Image(systemName: "sun.max") // 外层
                .font(.system(size: 44, weight: .light))
                .offset(x: isPress ? -90 : 0, y: isPress ? -90 : 0) // 用偏移来增加动画效果
                .rotation3DEffect(.degrees(isPress ? 20 : 0), axis: (x: 10, y: -10, z: 0)) // 用 3d 旋转效果
            
            Image(systemName: "moon") // 内层
            .font(.system(size: 44, weight: .light))
            .offset(x: isPress ? 0 : 90, y: isPress ? 0 : 90) // 用偏移来增加动画效果
            .rotation3DEffect(.degrees(isPress ? 0 : 20), axis: (x: -10, y: 10, z: 0)) // 用 3d 旋转效果
            
        }
        .frame(width: 100, height: 100)
            .background( // 在背景处设置阴影,内置阴影的基本思路就是：在 Z 轴添加阴影
                ZStack {
                    LinearGradient(gradient: Gradient(
                        colors: [Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    
                    Circle() // 左上内圈阴影
                        .stroke(Color.clear, lineWidth: 10) // 渲染
                        .shadow(color: Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: -5, y: -5)
                    
                    Circle() // 右下内置阴影
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 3, x: 3, y: 3)
                    
                }
        )
            .clipShape(Circle())
            .shadow(color: Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(isTap ? 1.2 : 1)
            .gesture(
                LongPressGesture().onChanged({ (value) in
                    self.isTap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isTap = false
                    }
                })
                    .onEnded({ (value) in
                        self.isPress.toggle()
                    })
        )
    }
}


// MARK: - 付款按钮：长按过程动画
struct PayButton: View {
    
    @GestureState var isTap = false
    @State var isPress = false
    
    var body: some View {
        ZStack { // 用 Z 轴，堆叠两个，长按进行变换
            Image("fingerprint") // 最外层
                .opacity(isPress ? 0 : 1)
                .scaleEffect(isPress ? 0 : 1)
            
            Image("fingerprint-2") // 中间层
                .clipShape(Rectangle().offset(y: isTap ? 0 : 50))
                .animation(.easeInOut) // 改变动画效果
                .opacity(isPress ? 0 : 1)
                .scaleEffect(isPress ? 0 : 1)
            
            Image(systemName: "checkmark.circle.fill") // 最上层
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                .opacity(isPress ? 1 : 0)
                .scaleEffect(isPress ? 1 : 0)
            
        }
        .frame(width: 120, height: 120)
            .background( // 在背景处设置阴影,内置阴影的基本思路就是：在 Z 轴添加阴影
                ZStack {
                    LinearGradient(gradient: Gradient(
                        colors: [Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    
                    Circle() // 左上内圈阴影
                        .stroke(Color.clear, lineWidth: 10) // 渲染
                        .shadow(color: Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: -5, y: -5)
                    
                    Circle() // 右下内置阴影
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 3, x: 3, y: 3)
                    
                }
        )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .trim(from: isTap ? 0.0001 : 1, to: 1) // 修剪，从：起始位置，到：结束位置
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round)) // 线性填充
                    .frame(width: 88, height: 88)
                    .rotationEffect(.degrees(90)) // 先旋转 90 度
                    .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0)) // 再 3D 旋转 180 度
                    .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3) // 阴影
                    .animation(.easeInOut) // 改变动画效果
            )
            .shadow(color: Color(isPress ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: Color(isPress ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(isTap ? 1.2 : 1)
            .gesture( // 这里是持续更新长按手势
                LongPressGesture().updating($isTap, body: { (currentState, gestureState, transaction) in
                    gestureState = currentState
                })
                    .onEnded({ (value) in
                        self.isPress.toggle()
                    })
        )
    }
}
