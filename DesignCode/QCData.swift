//
//  QCData.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/29.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - 数据结构
struct QCPost: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}


// MARK: - 网络工具
class QCNetworkTool {
    
    /// `完成回调`
    typealias QCCompletionHandler = (Any?, URLResponse?, Error?) -> Void
    
    /// `单例`
    static let shared: QCNetworkTool = {
        let tool = QCNetworkTool()
        return tool
    }()
    
    /// `JSON解析器`
    func QCJSONDecoder<T>(_ type: T.Type, from data: Data ) -> T where T: Decodable {
        let data = try! JSONDecoder().decode(type.self, from: data)
        return data
    }
    
    /// `基础网络方法`
    /// - Parameters:
    ///   - url: url
    ///   - finished: 完成回调
    private func network<T>(url: URL, _ type: T.Type, finished: @escaping QCCompletionHandler) where T: Decodable {
        URLSession.shared.dataTask(with: url, completionHandler: { (result, response, error) in
            if error != nil { print("网络错误\(String(describing: error))"); return }
            let JSONData = self.QCJSONDecoder(type.self, from: result!)
            DispatchQueue.main.async {
                finished(JSONData, response, error)
            }
        })
        .resume()
    }
    
    
    /// `获取解析好的数据`
    /// - Parameter finished: 回调
    func networkGetPost<T>(_ type: T.Type, finished: @escaping QCCompletionHandler) where T: Decodable {
        guard let url = URL(string: urlStr) else { return }
        QCNetworkTool.shared.network(url: url, type) { (data, response, error) in
            if error != nil { print("网络错误\(String(describing: error))"); return }
            DispatchQueue.main.async {
//                printQCDebug(message: data)
                finished(data, response, error)
            }
        }
    }
    
    
    /// `测试函数`
    func test() {
       guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { print("网络错误\(String(describing: error))"); return }
            let posts = try! JSONDecoder().decode([QCPost].self, from: data!)
            DispatchQueue.main.async {
                print(posts)
            }
        }
        .resume()
    }
}

// MARK: - 接口
let urlStr = "http://jsonplaceholder.typicode.com/posts" // 接口




// MARK: - DebugPrint
/// `调试输出`
func printQCDebug<T>(message: T, file: String = #file, method: String = #function, line: Int = #line ) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
