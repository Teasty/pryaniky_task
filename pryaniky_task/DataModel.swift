//
//  DataModel.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 16.10.2020.
//

import Foundation

struct DataFromServer {
    var data: [Any]
    var view: [String]
}

enum dataTypes {
    case text
    case picture
    case selector
}

struct Picture {
    let url: String
    let text: String
}

struct Selector {
    var selectedId: Int
    let variants: [Variant]
}

struct Variant {
    let id: Int
    let text: String
}

protocol DataServiceProtocol: AnyObject {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void)
}

class DataService: DataServiceProtocol {
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = URL(string: "https://pryaniky.com/static/json/sample.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            
            if let error = error {
                completion( .failure(error))
            }
            
            guard let data = data else { return }
            
            print(String(data: data, encoding: .utf8)!)
            
            completion( .success(data))
            
        }.resume()
        
    }
}
