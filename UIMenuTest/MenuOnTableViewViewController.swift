//
//  MenuOnTableViewViewController.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 11/1/23.
//

import UIKit

class MenuOnTableViewViewController: UIViewController {
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
    let label = UILabel()
    let actionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

}

extension MenuOnTableViewViewController {
    
    func setupController() {
        title = "Menu on TableView"
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        setupViews()
        
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(actionLabel)
        
        setupActionLabel()
        setupLabel()
        setupTableView()
        setupBarButton()
    }
    
    func setupLabel() {
        label.text = "A table View cell can have a menu embedded as part of its interaction, you add the menu with the 'func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?' method from the tableView delegate."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: actionLabel.topAnchor, constant: -60),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    func setupActionLabel() {
        actionLabel.text = "No Action Performed"
        actionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        actionLabel.textAlignment = .center
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            actionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            actionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            actionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Setup Table View
    func setupTableView() {
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    // MARK: - Action Label animation
    func animateActionLabelText(text: String) {
        UIView.transition(with: actionLabel, duration: 0.25, options: .transitionCrossDissolve) { [unowned self] in
            actionLabel.textColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            actionLabel.text = text
        } completion: { [unowned self] _ in
            UIView.transition(with: actionLabel, duration: 0.25, options: .transitionCrossDissolve) { [unowned self] in
                actionLabel.textColor = .black
                actionLabel.text = text
            }
        }
    }
    
    // MARK: - Next Button
    
    func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapAddButton))
    }
    
    @objc func didTapAddButton() {
        let controller = MenuOnCollectionViewViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - Table view Delegate and Data Source
extension MenuOnTableViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [unowned self] _ in
            animateActionLabelText(text: "Shared Action")
        }
        
        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "square.and.pencil")) { [unowned self] _ in
            animateActionLabelText(text: "Copy Action")
        }
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [unowned self] _ in
            animateActionLabelText(text: "Delete Action")
        }
        
        let menu = UIMenu(title: "Menu", children: [shareAction, copyAction, deleteAction])
        
        let contextMenuConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return menu
        }
        
        return contextMenuConfiguration
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = "Cell N \(indexPath.row)"
        contentConfiguration.secondaryText = "Secondary Text"
        
        cell.contentConfiguration = contentConfiguration
        return cell
    }
    
}
