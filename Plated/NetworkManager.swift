//
//  NetworkManager.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    typealias WebServiceResponse = (Decodable?, Error?) -> ()
    var realm = try! Realm()
    
    private init() { }
    
    fileprivate func authorize(url: URL, token: String) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.setValue("Token token=\(Constants.networkToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
        
    }
    
    internal func fetchDocumentsWithAlamofire<T: Decodable>(url: URL, completion: @escaping (T?, Error?) -> ()) {
        
        Alamofire.request(authorize(url: url, token: Constants.networkToken)).responseJSON { (response) in
            
            if let data = response.data, let object = try? JSONDecoder().decode(T.self, from: data) {
                completion(object, nil)
            } else if let error = response.error {
                completion(nil, error)
            }
        }
        
    }
}
