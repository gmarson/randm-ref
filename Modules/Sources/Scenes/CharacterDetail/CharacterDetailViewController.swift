//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 03/08/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import DesignSystem

public final class CharacterDetailViewController: UIViewController {
    
    let viewModel: CharacterDetailViewModel
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "rick")
        return image
    }()
    
    private lazy var profileName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.hugeBold
        return label
    }()
    
    private lazy var originInfoView: KeyValueView = {
        let model = KeyValueModel(key: "", value: "")
        let view = KeyValueView(model: model)
        return view
    }()
    
    private lazy var locationInfoView: KeyValueView = {
        let model = KeyValueModel(key: "", value: "")
        let view = KeyValueView(model: model)
        return view
    }()
    
    private lazy var genderInfoView: KeyValueView = {
        let model = KeyValueModel(key: "", value: "")
        let view = KeyValueView(model: model)
        return view
    }()
    
    private lazy var statusInfoView: KeyValueView = {
        let model = KeyValueModel(key: "", value: "")
        let view = KeyValueView(model: model)
        return view
    }()
    
    private lazy var favoriteButton: KeychainButton = {
        let model = KeychainButtonModel(action: .add)
        let button = KeychainButton(model: model)
        button.delegate = self
        return button
    }()
    
    private lazy var stackInfoView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = CGFloat.defaultPadding
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("We do not support storyboards")
    }

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        viewModel.getCharacterInfo()
    }
    
    func setupViews() {
        
        view.addSubview(profileName)
        view.addConstraints([
            profileName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultPadding),
            profileName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .bigPadding),
            profileName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .defaultPadding)
        ])
        
        view.addSubview(profileImage)
        profileImage.sizeConstraints(height: 200, width: 150)
        view.addConstraints([
            profileImage.centerXAnchor.constraint(equalTo: profileName.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: .bigPadding)
        ])
        
        view.addSubview(stackInfoView)
        stackInfoView.addArrangedSubview(locationInfoView)
        stackInfoView.addArrangedSubview(originInfoView)
        stackInfoView.addArrangedSubview(genderInfoView)
        stackInfoView.addArrangedSubview(statusInfoView)
        view.addConstraints([
            stackInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .bigPadding),
            stackInfoView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: .bigPadding),
            stackInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1 * .bigPadding)
        ])
        
        view.addSubview(favoriteButton)
        view.addConstraints([
            favoriteButton.leadingAnchor.constraint(equalTo: stackInfoView.leadingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: stackInfoView.bottomAnchor, constant: .bigPadding),
            favoriteButton.trailingAnchor.constraint(equalTo: stackInfoView.trailingAnchor)
        ])
        
    }

}

extension CharacterDetailViewController: CharacterDetailViewModelStateHandler {
    
    private func fillScreen(character: Character) {
        profileName.text = character.name
        
        if character.origin.name.notUnknown() {
            originInfoView.updateModel(model: .init(key: "Origin: ", value: character.origin.name))
        }
        
        if character.location.name.notUnknown() {
            locationInfoView.updateModel(model: .init(key: "Location: ", value: character.location.name))
        }
        
        if character.gender.notUnknown() {
            genderInfoView.updateModel(model: .init(key: "Gender: ", value: character.gender))
        }
        
        if character.status.notUnknown() {
            statusInfoView.updateModel(model: .init(key: "Status: ", value: character.status))
            //TODO create constant class for strings
        }
        
        if let data = character.imageData {
            profileImage.image = UIImage(data: data)
        }
    }
    
    func didChangeState(_ state: CharacterDetailViewModel.State) {
        switch state {
        case .idle:
            break
        case let .loaded(character, action):
            favoriteButton.updateModel(model: .init(action: action))
            fillScreen(character: character)
        case .addedToFavorites:
            favoriteButton.updateModel(model: .init(action: .delete))
        case .removeFromFavorites:
            favoriteButton.updateModel(model: .init(action: .add))
        case .error:
            break
            //TODO show message error
        }
    }
    
}

extension CharacterDetailViewController: KeychainButtonDelegate {
    func didTouchUpInside(_ action: KeychainButton.Action) {
        viewModel.handleKeychainButtonAction(action)
    }
    
}
