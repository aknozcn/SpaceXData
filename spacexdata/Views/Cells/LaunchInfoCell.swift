//
//  LaunchInfoCell.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

import UIKit

class LaunchInfoCell: UICollectionViewCell {

    static let identifier = Texts.launchInfoCellIdentifier
    
    //MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    // MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    // MARK: - Public Methods
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}

// MARK: - Private Methods
private extension LaunchInfoCell {
    func configureViews() {
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 243 / 255, green: 244 / 255, blue: 250 / 255, alpha: 1).cgColor
    }
}
