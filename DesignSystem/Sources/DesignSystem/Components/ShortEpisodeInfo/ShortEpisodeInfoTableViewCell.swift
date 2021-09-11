//
//  File.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation
import UIKit

public struct EpisodeShortInfoViewModel: ViewCodeModel {
    
    public init(
        name: String,
        airDate: String
    ) {
        self.name = name
        self.airDate = airDate
    }
    
    let name: String
    let airDate: String
}

public final class EpisodeInfoTableViewCell: UITableViewCell, ViewCodeLifeCycle, OptionalModelManager {
    
    public var model: EpisodeShortInfoViewModel?
    
    public static let reuseIdentifier = "EpisodeInfoTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regularBold
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        render()
    }
    
    public func createViews() { }
    
    public func addSubviews() {
        addSubview(nameLabel)
    }
    
    public func setupLayout() {
        nameLabel.pinToSuperView()
        
//        addConstraints([
//            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .defaultPadding),
//            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .defaultPadding),
//        ])
    }
    
    public func updateModel(model: EpisodeShortInfoViewModel?) {
        self.model = model
        nameLabel.text = model?.name
    }
}
