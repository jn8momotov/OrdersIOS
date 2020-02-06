//
//  NetworkService.swift
//  OrdersApp
//
//  Created by Момотов Евгений Олегович on 05.02.2020.
//  Copyright © 2020 Momotov. All rights reserved.
//

import Foundation

protocol NetworkService {
    func post<T: Codable>(_ model: T, completion: @escaping (Data?, Error?) -> Void)
    func get<T: Codable>(_ type: T.Type, completion: @escaping (T?, Error?) -> Void)
    func put<T: Codable>(_ model: T, completion: @escaping (Data?, Error?) -> Void)
    func delete(id: Int, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkServiceImpl: NetworkService {
    private let url = "http://localhost:8080"
    
    func post<T: Codable>(_ model: T, completion: @escaping (Data?, Error?) -> Void) {
        let urlString = "\(url)/orders"
        guard let url = URL(string: urlString), let data = try? JSONEncoder().encode(model) else {
            return
        }
        let request = createRequest(url: url, method: .post, body: data)
        let task = dataTask(request: request, completion: completion)
        task.resume()
    }
    
    func get<T: Codable>(_ type: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let urlString = "\(url)/orders"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = createRequest(url: url, method: .get)
        let task = dataTask(request: request) { data, error in
            if let data = data, let model = try? JSONDecoder().decode(type, from: data) {
                completion(model, error)
                return
            }
            completion(nil, error)
        }
        task.resume()
    }
    
    func put<T: Codable>(_ model: T, completion: @escaping (Data?, Error?) -> Void) {
        let urlString = "\(url)/orders"
        guard let url = URL(string: urlString), let data = try? JSONEncoder().encode(model) else {
            return
        }
        let request = createRequest(url: url, method: .put, body: data)
        let task = dataTask(request: request, completion: completion)
        task.resume()
    }
    
    func delete(id: Int, completion: @escaping (Data?, Error?) -> Void) {
        let urlString = "\(url)/orders/\(id)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = createRequest(url: url, method: .delete)
        let task = dataTask(request: request, completion: completion)
        task.resume()
    }
}

extension NetworkServiceImpl {
    private func createRequest(url: URL, method: HTTPMethod, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = method.rawValue
        request.timeoutInterval = 15
        request.httpBody = body
        return request
    }
    
    private func dataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            print("❌ Error request: \(String(describing: error))")
            print("↩️ Data request: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
            completion(data, error)
        })
    }
}
