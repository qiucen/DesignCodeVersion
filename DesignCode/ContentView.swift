//
//  ContentView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/25.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `卡片宽度`
private let kCardWidth: CGFloat = 340.0
/// `卡片高度`
private let kCardHeight: CGFloat = 220.0
/// `边角半径`
private let kDefaultRadius: CGFloat = 20.0
/// `旋转角度`
private let kRotationAngle: Double = 10

// MARK: - 屏幕视图
struct ContentView: View {
    
    /// `状态 - 是否出现`
    @State var isShow = false
    /// `初始大小值为0`
    @State var viewState = CGSize.zero
    /// `设置卡片初始状态为隐藏`
    @State var isShowCard = false
    
    var body: some View {
        ZStack { // 立体纬度，父容器
            
            
            TitleView() // 标题
                .blur(radius: isShow ? kDefaultRadius : 0) // 通过点击改变状态设置改变模糊
                .opacity(isShowCard ? 0.4 : 1) // 添加不透明度效果
                .offset(x: 0, y: isShowCard ? -100 : 0) // 添加偏移量
                .animation(
                    Animation
                        .default // 默认动画效果
                        .delay(0.1) // 添加延时
                    // 此外，还可添加速度、重复次数等属性
            ) // 添加默认动画效果
            
            // 这里的组件顺序： 从上到下依次是 从外到里（以我自身为里），也就是说，最上面的组件在最外面
            BackCardView() // 最外层View
                .frame(width: isShowCard ? kCardWidth - 40 : kCardWidth, height: kCardHeight)
                .background(isShow ? Color("background3") : Color("background10"))
                .cornerRadius(kDefaultRadius)
                .shadow(radius: kDefaultRadius) // 阴影
                .offset(x: 0, y: isShow ? -kDefaultRadius * 20 : -kDefaultRadius * 2) // 通过点击改变状态设置不同偏移量
                .offset(y: isShowCard ? -200 : 0) // 通过点击设置偏移量
                .offset(x: viewState.width, y: viewState.height) // 设置同卡片视图的联动偏移为：存储的值(随同一起动)
                .scaleEffect(isShowCard ? 1 : 0.9) // 缩放
                .rotationEffect(.degrees(isShow ? 0 : kRotationAngle)) // 通过点击改变状态设置不同偏移量
                .rotationEffect(.degrees(isShowCard ? -kRotationAngle : 0)) // 点击卡片改变旋转角度
                .rotation3DEffect(.degrees(isShowCard ? 0 : kRotationAngle), axis: (x: kDefaultRadius / 2, y: 0, z: 0))
                .blendMode(.hardLight) // 混合模式
                .animation(.easeInOut(duration: 0.5)) // 添加动画 - 淡入淡出，最上面一张卡片动画时长更长
            
            BackCardView() // 中间层 View
                .frame(width: kCardWidth, height: kCardHeight)
                .background(isShow ? Color("background10") : Color("background3"))
                .cornerRadius(kDefaultRadius)
                .shadow(radius: kDefaultRadius) // 阴影
                .offset(x: 0, y: isShow ? -kDefaultRadius * 10 : -kDefaultRadius) // 通过点击改变状态设置不同偏移量
                .offset(y: isShowCard ? -140 : 0) // 通过点击设置偏移量
                .offset(x: viewState.width, y: viewState.height) // 设置同卡片视图的联动偏移为：存储的值(随同一起动)
                .scaleEffect(isShowCard ? 1 : 0.95) // 缩放
                .rotationEffect(.degrees(isShow ? 0 : kRotationAngle / 2)) // 通过点击改变状态设置不同偏移量
                .rotationEffect(.degrees(isShowCard ? -kRotationAngle / 2 : 0)) // 点击卡片改变旋转角度
                .rotation3DEffect(.degrees(isShowCard ? 0 : kRotationAngle / 2), axis: (x: kDefaultRadius / 2, y: 0, z: 0))
                .blendMode(.hardLight) // 混合模式
                .animation(.easeInOut(duration: 0.3)) // 添加动画 - 淡入淡出
            // 关于动画时长：0.3s 是一个很好的动画持续时长，默认是 0.25
            
            CardView() // 卡片视图
                .frame(width: isShowCard ? UIScreen.main.bounds.width : kCardWidth, height: kCardHeight)
                .background(Color.black)
//                .cornerRadius(kDefaultRadius) // 圆角半径，修剪
                .clipShape(
                    RoundedRectangle(cornerRadius: isShowCard ? kDefaultRadius + 10 : kDefaultRadius, style: .continuous)
            ) // 设置边角裁剪样式
                .shadow(radius: kDefaultRadius) // 阴影
                // 这里修饰符的顺序很重要，如果把 .shadow 放在 .cornerRadius 之前，那么阴影将不再起作用
                // 因为：阴影被修剪掉了
                .offset(x: viewState.width, y: viewState.height) // 设置偏移为：存储的值
                .offset(x: 0, y: isShowCard ? -100 : 0) // 设置点击时偏移量
                // 注意这里：偏移设置在手势之前，目的是为了不产生滞后
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) // 设置过渡动画
                // response:整个过渡动画的反应时间，持续时长  dampingFraction:弹性系数，值越大，弹力越小
                .onTapGesture { // 点击
                    self.isShowCard.toggle()
            }
            .gesture( // 创建手势
                DragGesture().onChanged({ (value) in // 拖拽手势 - 拖拽变化
                    self.viewState = value.translation // value 存储了拖拽的 x 和 y 值
                    self.isShow = true // 设置状态，拖拽时打开
                })
                    .onEnded({ (value) in // 拖拽结束
                        self.viewState = .zero // 设置回初始值
                        self.isShow = false // 设置状态，结束拖拽时关闭
                    })
            )
            
            BottomCardView() // 底部视图
                .offset(x: 0, y: isShowCard ? 400 : 1000) // 设置点击时偏移量
                .blur(radius: isShow ? kDefaultRadius : 0) // 通过点击改变状态设置改变模糊
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8)) // 添加自定义时间曲线动画效果
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - 卡片视图
struct CardView: View {
    var body: some View {
        VStack { // 垂直维度
            HStack { // 水平维度
                VStack(alignment: .leading) {
                    Text("UI 设计")
                        .foregroundColor(.white) // 前景色
                        .font(.title) // 字体
                        .fontWeight(.semibold) // 字号
                    Text("证书")
                        .foregroundColor(Color("accent"))
                }
                Spacer() // 弹簧
                Image("Logo")
            }
                .padding(.horizontal, kDefaultRadius) // 填充：水平表示左右均填充
                .padding(.top, kDefaultRadius) // 填充，上部
            Spacer()
            Image("Illustration1")
                .resizable()
                .aspectRatio(contentMode: .fill) // 图片填充模式
                .frame(width: kCardWidth, height: kCardHeight / 2, alignment: .top)
        }
    }
}


// MARK: - 卡片背景视图
struct BackCardView: View {
    var body: some View {
        HStack{ // 这里的堆叠只是为了方便设置下面的属性，HStack 和 VStack都一样
            Spacer()
        }
    }
}

// MARK: - 标题视图
struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("证书")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background")
            Spacer()
        }
    }
}


// MARK: - 底部视图
struct BottomCardView: View {
    var body: some View {
        VStack(spacing: kDefaultRadius) {
            Rectangle() // 圆角矩形
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1) // 不透明度
            
            Text("春天，十个海子全都复活。在光明的景色中，嘲笑这一野蛮而悲伤的海子：你这么长久地沉睡到底是为了什么？")
                //                    .multilineTextAlignment(.center) // 设置多行文字居中对齐
                .font(.subheadline) // 字体
                .lineSpacing(4) // 行间距
            Spacer()
        }
            .padding(.top, 8) // 顶部 8 个点
            .padding(.horizontal, 20) // 左右各 20 个点
            .frame(maxWidth: .infinity) // 设置最大宽度
            .background(Color.white)
            // 如果要设置填充，在添加背景颜色之前，应该先设置填充，否则背景色不会设置到填充部分中
            .cornerRadius(30)
            .shadow(radius: kDefaultRadius)
    }
}
