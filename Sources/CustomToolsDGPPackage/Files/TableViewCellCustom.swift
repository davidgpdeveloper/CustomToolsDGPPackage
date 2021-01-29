//
//  TableViewCellCustom.swift
//  CustomToolsDGP
//
//  Created by David Galán on 03/10/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {
    
    let mainViewContainerCell = UIView()
    let separatorCell = UIView()
    let stackViewCell = UIStackView()
    var textLabelTitle = UILabel()
    var imageIconCell = UIImageView()
    var imageToLoadCell: UIImage?
    
    func loadCustomCell(backgroundColor: UIColor, textColor: UIColor, separatorColor: UIColor, textString: String, imageToLoadCellString: String? = "-1_-1") {
        
        imageToLoadCell = UIImage(named: imageToLoadCellString!)
        
        contentView.backgroundColor = .clear
        
        // View Container Main cell
        mainViewContainerCell.clipsToBounds = true
        mainViewContainerCell.backgroundColor = backgroundColor
        mainViewContainerCell.translatesAutoresizingMaskIntoConstraints = false
        
        // View Separator cell
        separatorCell.clipsToBounds = true
        separatorCell.backgroundColor = separatorColor
        separatorCell.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View cell
        stackViewCell.axis = NSLayoutConstraint.Axis.horizontal
        stackViewCell.distribution = UIStackView.Distribution.fill
        stackViewCell.alignment = UIStackView.Alignment.center
        stackViewCell.spacing = 16
        stackViewCell.clipsToBounds = true
        stackViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        // Label cell
        textLabelTitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textLabelTitle.text = textString
        textLabelTitle.textAlignment = .left
        textLabelTitle.numberOfLines = 1
        textLabelTitle.textColor = textColor
        textLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Image cell
        imageIconCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageIconCell.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageIconCell.clipsToBounds = true
        imageIconCell.layer.cornerRadius = 2
        imageIconCell.contentMode = .scaleAspectFit
        if imageToLoadCell != nil {
            imageIconCell.image = imageToLoadCell
        } else {
            imageIconCell.isHidden = true
        }
        imageIconCell.translatesAutoresizingMaskIntoConstraints = false
        
        // Aadd items to stackview
        stackViewCell.addArrangedSubview(imageIconCell)
        stackViewCell.addArrangedSubview(textLabelTitle)
        
        // Add items to container
        mainViewContainerCell.addSubview(separatorCell)
        mainViewContainerCell.addSubview(stackViewCell)
        
        contentView.addSubview(mainViewContainerCell)
        
        // Add constraints
        mainViewContainerCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        mainViewContainerCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        mainViewContainerCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        mainViewContainerCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        separatorCell.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorCell.bottomAnchor.constraint(equalTo: mainViewContainerCell.bottomAnchor, constant: 0).isActive = true
        separatorCell.leadingAnchor.constraint(equalTo: mainViewContainerCell.leadingAnchor, constant: 20).isActive = true
        separatorCell.trailingAnchor.constraint(equalTo: mainViewContainerCell.trailingAnchor, constant: -20).isActive = true
        
        stackViewCell.topAnchor.constraint(equalTo: mainViewContainerCell.topAnchor, constant: 0).isActive = true
        stackViewCell.bottomAnchor.constraint(equalTo: separatorCell.topAnchor, constant: 0).isActive = true
        stackViewCell.leadingAnchor.constraint(equalTo: mainViewContainerCell.leadingAnchor, constant: 24).isActive = true
        stackViewCell.trailingAnchor.constraint(equalTo: mainViewContainerCell.trailingAnchor, constant: -24).isActive = true
    }
    
}

