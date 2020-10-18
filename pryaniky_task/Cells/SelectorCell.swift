//
//  SelectorCell.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 18.10.2020.
//

import Foundation
import UIKit

class SelectorCell: UITableViewCell {
    
    var picker = UIPickerView()
    var pickerData = [Variant]()
    override init(style:UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        picker.delegate = self
        picker.dataSource = self
        
        addSubview(picker)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) was not implemented")
    }

    func setUpView() {
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 145).isActive = true
        picker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    func update(_ data: [Variant]) {
        self.pickerData = data
        self.picker.reloadAllComponents()
    }
}

extension SelectorCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = pickerData[row].text
        return row
    }
}

extension PictureCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        print("lol")
    }
}
