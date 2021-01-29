//
//  AlertTableViewCustomTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 25/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

public var isAlertTableViewCustomToolOpen = false

public protocol AlertTableViewCustomToolProtocol: class {
    func selectedItem(value: Any)
}

public class AlertTableViewCustomTool: UIViewController {
    
    public enum ButtonsFormatType: String {
        case stickedDown
        case withConstraints
    }
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    var viewContainer: UIView!
    var stackView: UIStackView!
    var imageIcon: UIImageView!
    var textLabelTitle: UILabel!
    var textLabel: UILabel!
    var viewSpace: UIView!
    var stackViewButtons: UIStackView!
    var buttonAccept: UIButton!
    var buttonMainContainer: UIButton!
    var buttonCloseTop: UIButton!
    var tableView: UITableView!
    
    // MARK: PARAMETERS
    let cellIdentifier = "AlertTableViewCustomToolCell"
    var acceptAction: ( ()->Void )?
    var data: [Any]?
    weak var delegateProtocol: AlertTableViewCustomToolProtocol?
    var cellHeight: CGFloat = 50
    var tableViewHeight: CGFloat = 150
    
    var cellBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var cellTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var cellSeparatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    // MARK: START METHODS
    public func show(delegate: AlertTableViewCustomToolProtocol, data: [Any], title: String?, message: String?, customImage: UIImage?, imageHeight: CGFloat = 80, imageWidth: CGFloat = 80, typeFormatViews: ButtonsFormatType = .stickedDown, topCloseButtonImage: UIImage? = nil, tableViewHeightValue: CGFloat = 150, cellHeightValue: CGFloat = 50, isActiveAcceptButton: Bool = false, addWhiteSpaceBottomMessage: Bool = false, cellBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cellTextColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cellSeparatorColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)) {
        
        // Initial control to not duplicate alerts
        guard !isAlertTableViewCustomToolOpen else {
            return
        }
        
        // Parameters
        let window = UIApplication.shared.keyWindow

        isAlertTableViewCustomToolOpen = true
        self.delegateProtocol = delegate
        self.data = data
        
        self.cellBackgroundColor = cellBackgroundColor
        self.cellTextColor = cellTextColor
        self.cellSeparatorColor = cellSeparatorColor
        
        if tableViewHeightValue > ((window?.layer.bounds.height)! / 2) {
            self.tableViewHeight = ((window?.layer.bounds.height)! / 2)
        } else {
            self.tableViewHeight = tableViewHeightValue
        }
        
        // View Container Main
        mainViewContainer = UIView()
        mainViewContainer.clipsToBounds = true
        mainViewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Container Main
        buttonMainContainer = UIButton()
        buttonMainContainer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0)
        buttonMainContainer.addTarget(self, action: #selector(buttonMainContainerAction), for: .touchUpInside)
        buttonMainContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // View Container
        viewContainer = UIView()
        viewContainer.layer.cornerRadius = 6
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderWidth = 3
        viewContainer.layer.borderColor = #colorLiteral(red: 0.1604149618, green: 0.1736847846, blue: 0.192962541, alpha: 1)
        viewContainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.95)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        
        if title == nil && message == nil && customImage == nil {
            stackView.spacing = 0
        } else {
            stackView.spacing = 20
        }
        
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if topCloseButtonImage != nil {
            // Button Close Top
            buttonCloseTop = UIButton()
            buttonCloseTop.clipsToBounds = true
            buttonCloseTop.setImage(topCloseButtonImage, for: .normal)
            buttonCloseTop.imageView?.contentMode = .scaleAspectFit
            buttonCloseTop.heightAnchor.constraint(equalToConstant: 40).isActive = true
            buttonCloseTop.widthAnchor.constraint(equalToConstant: 40).isActive = true
            buttonCloseTop.addTarget(self, action: #selector(buttonMainContainerAction), for: .touchUpInside)
            buttonCloseTop.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Image
        imageIcon = UIImageView()
        imageIcon.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageIcon.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageIcon.clipsToBounds = true
        imageIcon.layer.cornerRadius = 2
        imageIcon.contentMode = .scaleAspectFit
        if customImage != nil {
            imageIcon.image = customImage
        } else {
            imageIcon.isHidden = true
        }
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Label Title
        textLabelTitle = UILabel()
        textLabelTitle.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        textLabelTitle.text = title
        textLabelTitle.textAlignment = .center
        textLabelTitle.numberOfLines = 2
        textLabelTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Label
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textLabel.text = message
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if addWhiteSpaceBottomMessage {
            // View white space
            viewSpace = UIView()
            viewSpace.clipsToBounds = true
            viewSpace.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            viewSpace.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if isActiveAcceptButton {
            // Stack View Buttons
            stackViewButtons = UIStackView()
            stackViewButtons.axis = NSLayoutConstraint.Axis.horizontal
            stackViewButtons.distribution = UIStackView.Distribution.fillEqually
            stackViewButtons.alignment = UIStackView.Alignment.fill
            stackViewButtons.spacing = 16
            stackViewButtons.clipsToBounds = true
            stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
            
            // Button Accept
            buttonAccept = UIButton()
            buttonAccept.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8039215686, blue: 0.368627451, alpha: 1)
            buttonAccept.setTitle("Accept", for: .normal)
            buttonAccept.layer.cornerRadius = 4
            buttonAccept.addTarget(self, action: #selector(buttonAcceptAction), for: .touchUpInside)
        }
        
        // Table View
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCellCustom.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
//        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add items to stackView
        if isActiveAcceptButton {
            stackViewButtons.addArrangedSubview(buttonAccept)
        }
        
        stackView.addArrangedSubview(imageIcon)
        stackView.addArrangedSubview(textLabelTitle)
        stackView.addArrangedSubview(textLabel)
        
        if addWhiteSpaceBottomMessage {
            stackView.addArrangedSubview(viewSpace)
        }
        
        stackView.addArrangedSubview(tableView)
        
        if isActiveAcceptButton {
            stackView.addArrangedSubview(stackViewButtons)
        }
        
        // Add items to containers
        viewContainer.addSubview(stackView)
        if topCloseButtonImage != nil {
            viewContainer.addSubview(buttonCloseTop)
        }
        mainViewContainer.addSubview(buttonMainContainer)
        mainViewContainer.addSubview(viewContainer)
        
        // Add item to screen
        window?.addSubview(mainViewContainer)
        window?.bringSubviewToFront(mainViewContainer)
        
        // Add constraints
        mainViewContainer.widthAnchor.constraint(equalToConstant: window!.bounds.width).isActive = true
        mainViewContainer.heightAnchor.constraint(equalToConstant: window!.bounds.height).isActive = true
        mainViewContainer.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
        mainViewContainer.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
        
        buttonMainContainer.topAnchor.constraint(equalTo: mainViewContainer.topAnchor).isActive = true
        buttonMainContainer.bottomAnchor.constraint(equalTo: mainViewContainer.bottomAnchor).isActive = true
        buttonMainContainer.leadingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor).isActive = true
        buttonMainContainer.trailingAnchor.constraint(equalTo: mainViewContainer.trailingAnchor).isActive = true
        
        if topCloseButtonImage != nil {
            buttonCloseTop.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 5).isActive = true
            buttonCloseTop.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -5).isActive = true
        }
        
        viewContainer.topAnchor.constraint(greaterThanOrEqualTo: mainViewContainer.topAnchor, constant: 50).isActive = true
        viewContainer.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer.bottomAnchor, constant: 50).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor, constant: 30).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: mainViewContainer.trailingAnchor, constant: -30).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: mainViewContainer.centerYAnchor).isActive = true
        viewContainer.centerXAnchor.constraint(equalTo: mainViewContainer.centerXAnchor).isActive = true
        
        textLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        
        textLabelTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        textLabelTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        
        if addWhiteSpaceBottomMessage {
            viewSpace.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        
        tableView.heightAnchor.constraint(equalToConstant: tableViewHeight).isActive = true
        
        if isActiveAcceptButton {
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        switch typeFormatViews {
        case .stickedDown:
            
            tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
            
            if isActiveAcceptButton {
                stackViewButtons.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
                stackViewButtons.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
                
                stackViewButtons.spacing = 0
                buttonAccept.layer.cornerRadius = 0
            }
            
            if title == nil && message == nil && customImage == nil {
                stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 0).isActive = true
            } else {
                stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 50).isActive = true
            }
            stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 0).isActive = true
            
            break
        case .withConstraints:
            
            tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
            tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
            
            if isActiveAcceptButton {
                stackViewButtons.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
                stackViewButtons.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
            }
            
            stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 50).isActive = true
            stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -30).isActive = true
            
            break
        }

        stackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
    }
    
}


// MARK: BUTTON METHODS
extension AlertTableViewCustomTool {
    
    @objc func buttonMainContainerAction() {
        print("AlertCustomTool: buttonMainContainerAction")
        closeViewActions()
    }
    
    @objc func buttonAcceptAction() {
        print("AlertCustomTool: buttonAcceptAction")
        closeViewActions()
        if let action = self.acceptAction {
            action()
        }
    }
    
    public func addAcceptAction(_ action: @escaping ()->Void) {
        self.acceptAction = action
    }
    
    private func closeViewActions() {
        isAlertTableViewCustomToolOpen = false
        mainViewContainer.removeFromSuperview()
    }
    
}


// MARK: CUSTOMIZE VIEW METHODS
extension AlertTableViewCustomTool {
    
    // BACKGROUND
    public func setBackgroundColor(color: UIColor) {
        mainViewContainer.backgroundColor = color
    }
    
    // BUTTON BACKGROUND
    public func setButtonBackgroundDisable() {
        buttonMainContainer.isEnabled = false
    }
    
    // CONTAINER
    public func setContainerBackgroundColor(color: UIColor) {
        viewContainer.backgroundColor = color
    }
    public func setContainerCornerRadius(value: CGFloat) {
        viewContainer.layer.cornerRadius = value
    }
    public func setContainerBorder(value: CGFloat, color: UIColor) {
        viewContainer.layer.borderWidth = value
        viewContainer.layer.borderColor = color.cgColor
    }
    
    // STACK VIEW
    public func setStackViewSpacing(value: CGFloat) {
        stackView.spacing = value
    }
    public func setStackViewButtonsSpacing(value: CGFloat) {
        stackViewButtons.spacing = value
    }
    
    // IMAGE
    public func setImageCorner(value: CGFloat) {
        imageIcon.layer.cornerRadius = value
        imageIcon.layer.masksToBounds = true
    }
    public func setImageBorder(value: CGFloat, color: UIColor) {
        imageIcon.layer.borderWidth = value
        imageIcon.layer.borderColor = color.cgColor
    }
    
    // LABEL TITLE
    public func setLabelTitleFontSize(value: CGFloat) {
        textLabelTitle.font = textLabelTitle.font.withSize(value)
    }
    public func setLabelTitleFontSizeAndWeight(value: CGFloat, weight: UIFont.Weight) {
        textLabelTitle.font = UIFont.systemFont(ofSize: value, weight: weight)
    }
    public func setLabelTitleAlignment(value: NSTextAlignment) {
        textLabelTitle.textAlignment = value
    }
    public func setLabelTitleNumberLines(value: Int) {
        textLabelTitle.numberOfLines = value
    }
    public func setLabelTitleTextColor(color: UIColor) {
        textLabelTitle.textColor = color
    }
    public func setLabelTitleAttributedText(attributedText: NSAttributedString) {
        textLabelTitle.attributedText = attributedText
    }
    public func setLabelTitleHidden(isHidden: Bool) {
        textLabelTitle.isHidden = isHidden
    }
    
    // LABEL
    public func setLabelFontSize(value: CGFloat) {
        textLabel.font = textLabel.font.withSize(value)
    }
    public func setLabelFontSizeAndWeight(value: CGFloat, weight: UIFont.Weight) {
        textLabel.font = UIFont.systemFont(ofSize: value, weight: weight)
    }
    public func setLabelAlignment(value: NSTextAlignment) {
        textLabel.textAlignment = value
    }
    public func setLabelNumberLines(value: Int) {
        textLabel.numberOfLines = value
    }
    public func setLabelTextColor(color: UIColor) {
        textLabel.textColor = color
    }
    public func setLabelAttributedText(attributedText: NSAttributedString) {
        textLabel.attributedText = attributedText
    }
    public func setLabelHidden(isHidden: Bool) {
        textLabel.isHidden = isHidden
    }
    
    // TABLE VIEW
    public func setTableViewBackgorund(color: UIColor) {
        tableView.backgroundColor = color
    }
    public func setTableViewSeparator(style: UITableViewCell.SeparatorStyle) {
        tableView.separatorStyle = style
    }
    public func setTableViewSeparator(color: UIColor) {
        tableView.separatorColor = color
    }
    
    // BUTTONS
    public func setButtonAcceptBackground(color: UIColor) {
        buttonAccept.backgroundColor = color
    }
    public func setButtonAcceptCorner(value: CGFloat) {
        buttonAccept.layer.cornerRadius = value
    }
    public func setButtonAcceptTextColor(color: UIColor) {
        buttonAccept.setTitleColor(color, for: .normal)
    }
    public func setButtonAcceptTitle(text: String) {
        buttonAccept.setTitle(text, for: .normal)
    }
    public func setButtonAcceptAttributedText(attributedText: NSAttributedString) {
        buttonAccept.setAttributedTitle(attributedText, for: .normal)
    }
    
}

// MARK: ANIMATIONS
extension AlertTableViewCustomTool {
    
    public enum AnimationType: String {
        case disolveCenter
        case scaleCenter
    }
    
    public func setAnimationView(type: AnimationType, duration: TimeInterval = 0.2, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        switch type {
        case .disolveCenter:
            
            self.mainViewContainer.alpha = 0.0
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: duration, animations: {
                self.mainViewContainer.alpha = 1.0
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
        case .scaleCenter:
            
            self.viewContainer.alpha = 0
            self.viewContainer.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [.curveEaseOut], animations: {
                self.viewContainer.alpha = 1
                self.viewContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
            
        }
    }
    
}

// MARK: TABLE VIEW METHODS
extension AlertTableViewCustomTool: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCellCustom
        
        cell.loadCustomCell(
            backgroundColor: cellBackgroundColor,
            textColor: cellTextColor,
            separatorColor: cellSeparatorColor,
            textString: "\(data?[indexPath.row] ?? "?")"
        )
                
        if indexPath.row == 0 {
            cell.roundSpecificsCornersCells(corners: [.topLeft, .topRight], radius: 6)
            cell.separatorCell.isHidden = false
        } else if data?.count == indexPath.row+1 {
            cell.roundSpecificsCornersCells(corners: [.bottomLeft, .bottomRight], radius: 6)
            cell.separatorCell.isHidden = true
        } else {
            cell.roundSpecificsCornersCells(corners: [.bottomLeft, .bottomRight], radius: 0)
            cell.separatorCell.isHidden = false
        }
        
        if data?.count ?? 0 == 1 {
            cell.roundSpecificsCornersCells(corners: [.bottomLeft, .bottomRight], radius: 6)
            cell.separatorCell.isHidden = true
        }
        
        return cell
    }
}

extension AlertTableViewCustomTool: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item selected: \(indexPath.row+1)")
        delegateProtocol?.selectedItem(value: data?[indexPath.row] as Any)
        closeViewActions()
    }
}




