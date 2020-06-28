//
//  QCCourseListView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/28.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCCourseListView: View {
    var body: some View {
        VStack {
            QCCourseView()
        }
    }
}

struct QCCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        QCCourseListView()
    }
}

// MARK: - 课程卡片视图
struct QCCourseView: View {
    @State var isShow = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) { // 文本父容器
                Text("春天，十个海子").font(.title)
                Text("春天， 十个海子全都复活\n在光明的景色中\n嘲笑这一野蛮而悲伤的海子\n你这么长久地沉睡到底是为了什么？")
                Text("春天， 十个海子低低地怒吼\n围着你和我跳舞、唱歌\n扯乱你的黑头发， 骑上你飞奔而去， 尘土飞扬\n你被劈开的疼痛在大地弥漫")
                Text("在春天， 野蛮而复仇的海子\n就剩这一个， 最后一个\n这是黑夜的儿子， 沉浸于冬天， 倾心死亡\n不能自拔， 热爱着空虚而寒冷的乡村")
                Text("那里的谷物高高堆起， 遮住了窗子\n它们一半用于一家六口人的嘴， 吃和胃\n一半用于农业， 他们自己繁殖\n大风从东吹到西， 从北刮到南， 无视黑夜和黎明\n你所说的曙光究竟是什么意思")
            }
            .padding(50)
            .frame(maxWidth: isShow ? .infinity : kScreenRect.width - 60, maxHeight: isShow ? kScreenRect.height : 280, alignment: .top)
            .offset(y: isShow ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(isShow ? 1 : 0)
            VStack { // 卡片父容器
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("领先的 SwiftUI")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("20 节课")
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo"))
                            .resizable()
                            .frame(width: 36, height: 36)
                            .opacity(isShow ? 0 : 1) // 不透明度：0 显示，1 隐藏
                        VStack { // 关闭按钮
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(isShow ? 1 : 0)
                    }
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Illustration2"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(isShow ? 30 : 20) // 设置全屏幕是的填充边距
            .padding(.top, isShow ? 30 : 0) // 设置全屏幕是的填充边距
            .frame(maxWidth: isShow ? .infinity : kScreenRect.width - 60, maxHeight: isShow ? 460 : 290) // 卡片父容器尺寸
            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 30, x: 0, y: 30)
            .onTapGesture {
                self.isShow.toggle()
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}
