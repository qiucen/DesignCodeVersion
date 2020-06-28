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
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("领先的 SwiftUI")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text("20 节课")
                        .foregroundColor(Color.white.opacity(0.7))
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Logo"))
                    .resizable()
                    .frame(width: 30, height: 30)
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
//        .frame(width: isShow ? kScreenRect.width: kScreenRect.width - 60,
//               height: isShow ? kScreenRect.height : 280)
        .frame(maxWidth: isShow ? kScreenRect.width: kScreenRect.width - 60,
               maxHeight: isShow ? kScreenRect.height : 280)
        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onTapGesture {
            self.isShow.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
