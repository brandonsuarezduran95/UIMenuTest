//
//  MenuOnCollectionViewViewController.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 11/5/23.
//

import UIKit

class MenuOnCollectionViewViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    let label = UILabel()
    let actionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

}

extension MenuOnCollectionViewViewController {
    func setupController() {
        view.backgroundColor = .white
        title = "Menu On CollectionView"
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(label)
        view.addSubview(actionLabel)
        
        setupActionLabel()
        setupLabel()
        setupCollectionView()
        setupBarButton()
    }
    
    func setupActionLabel() {
        actionLabel.text = "No Action Performed"
        actionLabel.textAlignment = .center
        actionLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        actionLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            actionLabel.heightAnchor.constraint(equalToConstant: 30),
            actionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            actionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    func setupLabel() {
        label.text = "A Collection View cell can have a menu embedded as part of its interaction, you add the menu with the 'func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration?' method from the collectionView delegate."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: actionLabel.topAnchor, constant: -30),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    // MARK: - Setup CollectionView
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SampleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0)
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
        let controller = DeferredMenuViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


extension MenuOnCollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCollectionViewCell
        
        if indexPath.item % 2 == 0 {
            cell.configureCell(mainText: "This is a sample main text", secondaryText: "This is a secondary sample text", isImageActive: true)
        } else {
            cell.configureCell(mainText: "Here is another sample main text", secondaryText: "This is yet another secondary sample text", isImageActive: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Double = (view.bounds.width - 40.0)
        let height: Double = 80.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        let actionA = UIAction(title: "Edit", image: .init(systemName: "pencil")) { [unowned self] _ in
            animateActionLabelText(text: "Edit Action")
        }
        
        let actionB = UIAction(title: "Reload", image: .init(systemName: "arrow.clockwise")) { [unowned self] _ in
            animateActionLabelText(text: "Reload Action")
        }
        
        let actionC = UIAction(title: "Delete",image: .init(systemName: "trash"), attributes: .destructive) { [unowned self] _ in
            animateActionLabelText(text: "Delete Action")
        }
        
        let menu = UIMenu(title: "Menu", image: .init(systemName: "menubar.rectangle"), options: .displayInline, children: [actionA, actionB, actionC])
        
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            return menu
        })
        
        return contextMenu
    }
}

