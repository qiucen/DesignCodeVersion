//
//  QCCourseDetail.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/29.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct QCCourseDetail: View {
    
    var course: QCCourse
    @Binding var isShow: Bool
    @Binding var isActive: Bool
    @Binding var isActiveIndex: Int
    @Binding var isSrollable: Bool
    var bounds: GeometryProxy
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack { // 卡片父容器
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Text(course.subtitle)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                            VStack { // 关闭按钮
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.isShow = false
                                self.isActive = false
                                self.isActiveIndex = -1
                                self.isSrollable = false
                            }
                        }
                    }
                    Spacer()
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(isShow ? 30 : 20) // 设置全屏幕是的填充边距
                .padding(.top, isShow ? 30 : 0) // 设置全屏幕是的填充边距
                .frame(maxWidth: isShow ? .infinity : bounds.size.width - 60) // 卡片父容器尺寸
                .frame(height: isShow ? 460 : 290)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 30, x: 0, y: 30)
                
                VStack(alignment: .leading, spacing: 20) { // 文本父容器
                    Text("春天，十个海子").font(.title).bold()
                    Text("\n春天，十个海子全都复活\n在光明的景色中\n嘲笑这一野蛮而悲伤的海子\n你这么长久地沉睡到底是为了什么？\n\n春天，十个海子低低地怒吼\n围着你和我跳舞、唱歌\n扯乱你的黑头发，骑上你飞奔而去，尘土飞扬\n你被劈开的疼痛在大地弥漫\n\n在春天，野蛮而复仇的海子\n就剩这一个，最后一个\n这是黑夜的儿子，沉浸于冬天，倾心死亡\n不能自拔， 热爱着空虚而寒冷的乡村\n\n那里的谷物高高堆起，遮住了窗子\n它们一半用于一家六口人的嘴，吃和胃\n一半用于农业，他们自己繁殖\n大风从东吹到西，从北刮到南，无视黑夜和黎明\n你所说的曙光究竟是什么意思\n\n\n\n\n\n\n\n")
                        // 搞不清楚这里为什么需要加上这么多换行符，不加这许多换行符就显示不完全
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .frame(maxHeight: .infinity)
                        .lineSpacing(6)
                }
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct QCCourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            QCCourseDetail(course: courseData[0], isShow: .constant(true), isActive: .constant(true), isActiveIndex: .constant(-1), isSrollable: .constant(true), bounds: bounds)
        }
    }
}
