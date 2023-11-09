//
//  SampleCollectionViewCell.swift
//  UIMenuTest
//
//  Created by Brandon Suarez on 11/5/23.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    
    fileprivate enum Constants {
        static let verticalSpacing: CGFloat = 15
        static let horizontalSpacing: CGFloat = 15
        static let filledStart: String = "star.fill"
        static let emptyStart: String = "star"
    }
    
    let mainText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Sample"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.text = "Sample"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(mainText)
        contentView.addSubview(secondaryText)
        contentView.addSubview(imageView)
        
        // main text
        NSLayoutConstraint.activate([
            mainText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpacing),
            mainText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.horizontalSpacing),
            mainText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.horizontalSpacing),
        ])
        
        // secondary text
        NSLayoutConstraint.activate([
            
            secondaryText.topAnchor.constraint(greaterThanOrEqualTo: mainText.bottomAnchor, constant: 10),
            secondaryText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.horizontalSpacing),
            secondaryText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalSpacing),
            secondaryText.rightAnchor.constraint(lessThanOrEqualTo: imageView.leftAnchor, constant: -10)
        ])
        
        // image view
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.centerYAnchor.constraint(equalTo: secondaryText.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),

        ])
        
    }
    
    func configureCell(mainText: String, secondaryText: String, isImageActive: Bool) {
        self.mainText.text = mainText
        self.secondaryText.text = secondaryText
        self.imageView.image = isImageActive ? .init(systemName: Constants.filledStart) : .init(systemName: Constants.emptyStart)
    }
    
    
}
