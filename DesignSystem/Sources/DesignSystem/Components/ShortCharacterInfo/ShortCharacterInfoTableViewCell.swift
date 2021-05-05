//
//  ShortCharacterInfoTableViewCell.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 31/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import Common
import SDWebImage

public struct CharacterShortInfoViewModel: ViewCodeModel {
    
    public init(
        name: String,
        origin: String,
        gender: String,
        status: String
    ) {
        self.name = name
        self.status = status
        self.origin = origin
        self.gender = gender
    }
    
    let name: String
    let origin: String
    let gender: String
    let status: String
}

public final class ShortCharacterInfoTableViewCell: UITableViewCell, ViewCodeLifeCycle, OptionalModelManager {
    
    public var model: CharacterShortInfoViewModel?
    
    public static let reuseIdentifier = "ShortCharacterInfoTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .largeBold
        return label
    }()
    
    private var shortInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2.0
        return stackView
    }()
    
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "rick")
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        render()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = #imageLiteral(resourceName: "rick")
        model = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createViews() { }
    
    public func addSubviews() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(shortInfoStackView)
        shortInfoStackView.addArrangedSubview(originLabel)
        shortInfoStackView.addArrangedSubview(genderLabel)
        shortInfoStackView.addArrangedSubview(statusLabel)
    }
    
    public func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profileImage.sizeConstraints(height: 80.0, width: 80.0)
        
        contentView.addConstraints([
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .defaultPadding)
        ])
        
        contentView.addConstraints([
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: .defaultPadding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .defaultPadding)
        ])
        
        contentView.addConstraints([
            shortInfoStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            shortInfoStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            shortInfoStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .defaultPadding)
        ])
        
    }
    
    public func updateModel(model: CharacterShortInfoViewModel?) {
        nameLabel.text = model?.name
        
        if let origin = model?.origin, origin.differentFromUnknown {
            originLabel.attributedText = NSMutableAttributedString(texts: [
                (text: "Origin: ", font: UIFont.regularBold),
                (text: origin, font: UIFont.regular)
            ])
        }
        
        if let gender = model?.gender, gender.differentFromUnknown {
            genderLabel.attributedText = NSMutableAttributedString(texts: [
                (text: "Gender: ", font: UIFont.regularBold),
                (text: gender, font: UIFont.regular)
            ])
        }

        if let status = model?.status, status.differentFromUnknown {
            statusLabel.attributedText = NSMutableAttributedString(texts: [
                (text: "Status: ", font: UIFont.regularBold),
                (text: status, font: UIFont.regular)
            ])
        }
    }
    
    public func updateImage(image: UIImage) {
        UIView.transition(
            with: profileImage,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.profileImage.image = image
            },
            completion: nil
        )
    }
    
}
