//
//  MenuWithSeparatorsViewController.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 10/21/23.
//

import UIKit

class MenuWithSeparatorsViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    let actionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupMenuAndSubMenu()
        setupToolBar()
    }

}

extension MenuWithSeparatorsViewController {
    func setupController() {
        view.backgroundColor = .white
        title = "SubMenus"
    }
    
    func setupViews() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(actionLabel)
        
        setupLabel()
        setUpButton()
        setupActionLabel()
        setupRightButtons()
    }
    
    // MARK: UI Elements
    
    func setupLabel() {
        
        label.text = "A SubMenu is a Menu as part of a Menu's children objects, in essence, create a menu and pass it as an object on the children's array on the UIMenu initialization, There are three Menu options: .destructive, .displayInLine, 'default'."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 5
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    func setUpButton() {
        button.setTitle("UIMenu", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 130),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupActionLabel() {
        
        actionLabel.text = "No Action Performed"
        actionLabel.textAlignment = .center
        actionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        actionLabel.layer.backgroundColor = UIColor.clear.cgColor
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140),
            actionLabel.leftAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            actionLabel.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    // MARK: - Right Navigation Bar Button
    func setupRightButtons() {
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNextButton))
        
        let subMenu = UIMenu(title: "Much More", options: .displayInline, children: (4...5).map({ item in
            UIAction(title: "\(item)") { [unowned self] _ in
                self.setActionLabelText(text: "\(item)")
            }
        }))
        
        var menuButtons: [UIMenuElement] = (0...3).map { item in
            UIAction(title: "\(item)") { [unowned self] _ in
                self.setActionLabelText(text: "\(item)")
            }
        }
        menuButtons.append(subMenu)
        
        let menu = UIMenu(title: "More", children: menuButtons )
        
        let plusButton = UIBarButtonItem(systemItem: .add , primaryAction: nil, menu: menu)
                                             
        navigationItem.rightBarButtonItems = [nextButton, plusButton]
    }
    
    @objc func didTapNextButton() {
        let controller = MenuOnTableViewViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - SubMenu
    
    func setupMenuAndSubMenu() {
        
        
        // Actions for the menu
        let refreshAction = UIAction(title: "Refresh", image: UIImage(systemName: "arrow.clockwise")) { [unowned self]  _ in
            setActionLabelText(text: "Refreshed Performed")
        }
        
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [unowned self] _ in
            setActionLabelText(text: "Delete Performed")
        }
        // Actions for the submenu
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [unowned self] _ in
            setActionLabelText(text: "Edit Performed")
        }
        
        let favoriteAction = UIAction(title: "Favorite", image: UIImage(systemName: "star")) { [unowned self] _ in
            setActionLabelText(text: "Favorite Performed")
        }
        
        // SubMenu
        let submenu = UIMenu(title: "Sub Menu", children: [editAction, favoriteAction])
        
        // Menu
        let menu = UIMenu(title: "Menu", children: [refreshAction, deleteAction, submenu])
        
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
    // MARK: -Text Label Animation
    
    func setActionLabelText(text: String) {
        UIView.transition(with: actionLabel, duration: 0.25, options: .transitionCrossDissolve) { [unowned self] in
            self.actionLabel.text = text
            self.actionLabel.textColor = .white
        } completion: { [unowned self] _ in
            self.actionLabel.textColor = .black
            self.actionLabel.text = text
        }
    }
    
    // MARK: - SetupToolBar
    
    func setupToolBar() {
        var primaryActions: [UIMenuElement] = (0...2).map { item in
            UIAction(title: "\(item)") { [unowned self] _ in
                self.setActionLabelText(text: "ToolBar Action: \(item)")
            }
        }
        
        let secondaryActions: [UIMenuElement] = (3...5).map { item in
            UIAction(title: "\(item)") { [unowned self] _ in
                self.setActionLabelText(text: "ToolBar Action: \(item)")
            }
        }
        
        let submenu = UIMenu(title: "More", options: .destructive, children: secondaryActions)
        let secondSubmenu = UIMenu(title: "Much More", options: .singleSelection, children: secondaryActions)
        primaryActions.append(submenu)
        primaryActions.append(secondSubmenu)
        
        let menu = UIMenu(title: "ToolBar Menu", image: nil, children: primaryActions)

        
        let toolbarButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), primaryAction: nil, menu: menu)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let rightToolBarButton = UIBarButtonItem(barButtonSystemItem: .edit , target: self,action: #selector(didTapRightToolBarButton))
        
        navigationController?.isToolbarHidden = false
        toolbarItems = [toolbarButton, spacer, rightToolBarButton]
        
    }
    
    @objc func didTapRightToolBarButton() {
        setActionLabelText(text: "ToolBar Button Tapped")
    }

}
