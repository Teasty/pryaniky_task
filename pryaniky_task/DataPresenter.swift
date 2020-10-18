//
//  DataPresenter.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 16.10.2020.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    func fetchData()
}

protocol PresenterDelegate: AnyObject {
    func render(errorMessage: String)
    func render(data _:[Any])
}

class Presenter: PresenterProtocol {
    
    let parser = Parser()
    var list = [Any]()
    
    private var service: DataServiceProtocol
    private weak var delegate: PresenterDelegate?
    
    init(service: DataServiceProtocol, delegate: PresenterDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
    func fetchData() {
        
        var objects = [[dataTypes:Any]]()
        
        service.fetchData(completion: { result in
            switch result {
            case .failure(let error):
                self.delegate?.render(errorMessage: error.localizedDescription)
            case .success(let data):
                do {
                    let responseData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    if let newData = responseData?["data"] as? [[String:Any]] {
                        
                        for e in newData {
                            objects.append(self.parser.parseData(e))
                        }
                    }
                    
                    if let newView = responseData?["view"] as? [String] {
                        let order = self.parser.parseView(newView)
                        for e in order {
                            switch e {
                            case .text:
                                self.list.append((objects.first(where: { $0.keys.first == .text }) as! [dataTypes:String]).values.first!)
                            case .picture:
                                self.list.append((objects.first(where: { $0.keys.first == .picture }) as! [dataTypes:Picture]).values.first!)
                            case .selector:
                                self.list.append((objects.first(where: { $0.keys.first == .selector }) as! [dataTypes:Selector]).values.first!)
                            }
                        }
                        print(self.list)
                        self.delegate?.render(data: self.list)
                    }
                } catch {
                    print("error")
                }
            }
        })
    }
}
