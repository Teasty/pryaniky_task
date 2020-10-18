//
//  PictureCell.swift
//  pryaniky_task
//
//  Created by Андрей Лихачев on 18.10.2020.
//

import UIKit

class PictureCell: UITableViewCell {
    
    var myPicture = UIImageView()
    var myText = UILabel()

    override init(style:UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(myPicture)
        addSubview(myText)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) was not implemented")
    }

    func setUpView() {
        myPicture.layer.cornerRadius = 10
        myPicture.clipsToBounds = true
        
        myText.numberOfLines = 0
        myText.adjustsFontSizeToFitWidth = true
        
        myPicture.translatesAutoresizingMaskIntoConstraints = false
        myPicture.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myPicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        myPicture.heightAnchor.constraint(equalToConstant: 80).isActive = true
        myPicture.widthAnchor.constraint(equalTo: myPicture.heightAnchor, multiplier: 1/1).isActive = true
        
        myText.translatesAutoresizingMaskIntoConstraints = false
        myText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myText.leadingAnchor.constraint(equalTo: myPicture.trailingAnchor, constant: 10).isActive = true
        myText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        myText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
}
