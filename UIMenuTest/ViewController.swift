//
//  ViewController.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 10/21/23.
//

import UIKit

class ViewController: UIViewController {
    let button = UIButton()
    let label = UILabel()
    let actionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupUIMenu()
    }
    
}

// MARK: - UIMenu

extension ViewController {
    
    func setupUIMenu() {
        let actionA = UIAction(title: "Share", image: .init(systemName: "paperplane.fill"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { [unowned self] action in
            print("Action Share Performed")
            self.setActionLabelText(text: "Action Share Performed")
        }
        
        let actionB = UIAction(title: "Copy", image: .init(systemName: "ellipsis.curlybraces"), identifier: nil, discoverabilityTitle: nil, attributes: [.keepsMenuPresented], state: .off) { [unowned self] action in
            print("Action Copy Performed")
            self.setActionLabelText(text: "Action Copy Performed")
        }
        
        let actionC = UIAction(title: "Hiden", image: .init(systemName: "eye.slash"), identifier: nil, discoverabilityTitle: nil, attributes: [.disabled], state: .off) { [unowned self] action in
            print("Action Hiden Performed")
            self.setActionLabelText(text: "Action Hiden Performed")
        }
        
        let actionD = UIAction(title: "Delete", image: .init(systemName: "trash"), identifier: nil, discoverabilityTitle: nil, attributes: [.destructive], state: .off) { [unowned self] action in
            print("Action Delete Performed")
            self.setActionLabelText(text: "Action Delete Performed")
        }
        
        let actionE = UICommand(title: "Command", image: .init(systemName: "list.dash.header.rectangle"),action: #selector(didTapActionE))
        
        let menu = UIMenu(title: "Options Menu", children: [actionA, actionB, actionC, actionD])
        
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
    @objc func didTapActionE() {
        setActionLabelText(text: "Action Command Performed")
    }

}

// MARK: - Set up
extension ViewController {
    
    func setupController() {
        view.backgroundColor = .white
        title = "UIMenu"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
        setupBarButton()
    }
    
    func setupViews() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(actionLabel)
        
        setupLabel()
        setUpButton()
        setupActionLabel()
    }
    
    func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapAddButton))
    }
    
    @objc func didTapAddButton() {
        let controller = MenuWithSeparatorsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupLabel() {
        
        label.text = "A UIMenu, is composed out of UIAction elements, which are added as part of the UIMenu's initialization."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 4
        
        
        
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
        button.backgroundColor = .systemBlue
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
    
    func setActionLabelText(text: String) {
        UIView.transition(with: actionLabel, duration: 0.25, options: .transitionCrossDissolve) { [unowned self] in
            self.actionLabel.textColor = .white
            self.actionLabel.text = text
        } completion: { [unowned self] _ in
            UIView.transition(with: actionLabel, duration: 0.25, options: .transitionCrossDissolve) { [unowned self] in
                self.actionLabel.textColor = .black
                self.actionLabel.text = text
            }
        }

    }
    
}

