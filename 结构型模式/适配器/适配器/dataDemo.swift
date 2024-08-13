//
//  dataDemo.swift
//  适配器
//
//  Created by wangyang on 2024/8/12.
//

import Foundation

// 新的数据访问接口
protocol NewDataAccess {
    func fetchData(completion: @escaping (Result<String, Error>) -> Void)
}
  
// Result 是一个泛型枚举，用于表示异步操作的结果
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
  
// 旧的数据访问类
class OldDataAccess {
    func fetchOldStyleData(completion: @escaping (String?, Error?) -> Void) {
        // 模拟异步数据获取
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let error: Error? = nil // 假设没有错误
            let data = "Old style data"
            completion(data, error)
        }
    }
}
  
// 适配器类
class DataAccessAdapter: NewDataAccess {
    private let oldDataAccess: OldDataAccess
  
    init(oldDataAccess: OldDataAccess) {
        self.oldDataAccess = oldDataAccess
    }
  
    func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
        oldDataAccess.fetchOldStyleData { oldStyleData, oldStyleError in
            if let error = oldStyleError {
                completion(.failure(error))
            } else if let data = oldStyleData {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "OldDataAccess", code: 0, userInfo: nil)))
            }
        }
    }
}
  
