//
//  DeferredMenuViewController.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 11/7/23.
//

import UIKit

class DeferredMenuViewController: UIViewController {
    let button = UIButton()
    let label = UILabel()
    let actionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupDeferredMenu()
    }
    
}

// MARK: - UIMenu

extension DeferredMenuViewController {
    
    func setupDeferredMenu() {
        let actionA = UIAction(title: "Share", image: .init(systemName: "paperplane.fill"), identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { [unowned self] action in
            print("Action Share Performed")
            self.setActionLabelText(text: "Action Share Performed")
        }
        
        let actionB = UIAction(title: "Copy", image: .init(systemName: "ellipsis.curlybraces"), identifier: nil, discoverabilityTitle: nil, attributes: [.keepsMenuPresented], state: .off) { [unowned self] action in
            print("Action Copy Performed")
            self.setActionLabelText(text: "Action Copy Performed")
        }
        
        let actionC = UIAction(title: "Hidden", image: .init(systemName: "eye.slash"), identifier: nil, discoverabilityTitle: nil, attributes: [.disabled], state: .off) { [unowned self] action in
            print("Action Hiden Performed")
            self.setActionLabelText(text: "Action Hidden Performed")
        }
        
        let asyncItem = UIDeferredMenuElement {  completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let favoriteAction = UIAction(title: "Favorite", image: UIImage(systemName: "star")) { [unowned self] _ in
                    self.setActionLabelText(text: "Action Favorited Performed")
                }
                let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [unowned self] (_) in
                    
                    self.setActionLabelText(text: "Action Edit Performed")
                }
                completion([favoriteAction, editAction])
            }
        }
        
        let actionD = UIAction(title: "Delete", image: .init(systemName: "trash"), identifier: nil, discoverabilityTitle: nil, attributes: [.destructive], state: .off) { [unowned self] action in
            print("Action Delete Performed")
            self.setActionLabelText(text: "Action Delete Performed")
        }
        
        let menu = UIMenu(title: "Options Menu", children: [actionA, actionB, actionC, actionD, asyncItem])
        
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }

}

// MARK: - Set up
extension DeferredMenuViewController {
    
    func setupController() {
        view.backgroundColor = .white
        title = "Deferred Menu Element"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(actionLabel)
        
        setupLabel()
        setUpButton()
        setupActionLabel()
    }
    
    func setupLabel() {
        
        label.text = "A UIDeferredMenuElement, is used when the action cannot be shown right away, i.e. something must load first, in this case you can use the deferred menu element to load an action, just use the initializer, and pass the actions to the input type of the closure."
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
