//
//  Parser.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 16.10.2020.
//

import Foundation

class Parser {
    func parseData(_ data: [String:Any]) -> [dataTypes:Any] {
        
        switch data["name"] as! String {
        case "hz":
            let newData = data["data"] as! [String:Any]
            let newDict:[dataTypes:String] = [
                .text : newData["text"] as! String
            ]
            return newDict
        case "picture":
            let newData = data["data"] as! [String:Any]
            let newPic = Picture(url: newData["url"] as! String, text: newData["text"] as! String)
            let newDict:[dataTypes:Picture] = [
                .picture : newPic
            ]
            return newDict
        case "selector":
            let newData = data["data"] as! [String:Any]
            let newSelector = Selector(selectedId: newData["selectedId"] as! Int, variants: self.parseVariants(newData["variants"] as! [[String:Any]]))
            let newDict:[dataTypes:Selector] = [
                .selector : newSelector
            ]
            return newDict
        default:
            return [dataTypes:Any]()
        }
    }
    
    func parseView(_ data: [String]) -> [dataTypes] {
        
        var list = [dataTypes]()
        
        for e in data {
            switch e {
            case "hz":
                list.append(.text)
            case "picture":
                list.append(.picture)
            case "selector":
                list.append(.selector)
            default:
               break
            }
        }
        return list
    }
    
    func parseVariants(_ data: [[String:Any]]) -> [Variant] {
        var vars = [Variant]()
        
        for e in data {
            vars.append(Variant(id: e["id"] as! Int, text: e["text"] as! String))
        }
        
        return vars
    }
}
