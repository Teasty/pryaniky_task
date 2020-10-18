//
//  ViewController.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 16.10.2020.
//

import UIKit
import AUPickerCell

class ViewController: UIViewController {
    
    var tableView = UITableView()
    var tableData = [Any]()
    var presenter: PresenterProtocol?
    /* IBOutlets here */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(service: DataService(), delegate: self)
        setUpTableView()
        presenter?.fetchData()
        
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "my")
        
        //        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //        let displayWidth: CGFloat = self.view.frame.width
        //        let displayHeight: CGFloat = self.view.frame.height
        
        tableView.contentInset.top = 20
        //        tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let contentSize = self.tableView.contentSize
        let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                          y: self.tableView.frame.origin.y + contentSize.height,
                                          width: self.tableView.frame.size.width,
                                          height: self.tableView.frame.height - self.tableView.contentSize.height))
        
        self.tableView.tableFooterView = footer
        
        
        view.addSubview(tableView)
    }
}

extension ViewController: PresenterDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        switch tableData[indexPath.row] {
    //        case is String:
    //            return 45
    //        case is Picture:
    //            return 100
    //        case is Selector:
    //            return 150
    //        default:
    //            return 30
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableData[indexPath.row] {
        case is String:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "TextCell")
            cell.textLabel?.text = tableData[indexPath.row] as? String
            return cell
        case is Picture:
            let cell = PictureCell()
            cell.myText.text = (tableData[indexPath.row] as? Picture)?.text
            cell.myPicture.loadWithURL(url: URL(string: (tableData[indexPath.row] as? Picture)!.url)!)
            return cell
        case is Selector:
            let cell = AUPickerCell(type: .default, reuseIdentifier: "TableCell")
            var values = [String]()
            for e in (tableData[indexPath.row] as? Selector)!.variants {
                values.append(e.text)
            }
            cell.values = values
            cell.selectedRow = (tableData[indexPath.row] as? Selector)!.selectedId
            cell.leftLabel.text = "Варианты"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
            return cell.height
        }
        switch tableData[indexPath.row] {
        case is String:
            return 45
        case is Picture:
            return 100
        default:
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
            cell.selectedInTableView(tableView)
        } else {
            
            if let cell = tableView.cellForRow(at: indexPath) as? PictureCell {
                let alert = UIAlertController(title: "Оповещение", message: cell.myText.text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if let cell = tableView.cellForRow(at: indexPath) {
                let alert = UIAlertController(title: "Оповещение", message: cell.textLabel?.text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func render(data: [Any]) {
        self.tableData = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func render(errorMessage: String) {
        print(errorMessage)
    }
}

extension UIImageView {
    func loadWithURL(url: URL){
        image = UIImage()
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                if let data = data{
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}


