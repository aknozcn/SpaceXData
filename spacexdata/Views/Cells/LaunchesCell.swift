//
//  LaunchesCell.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import UIKit
import Kingfisher

class LaunchesCell: UITableViewCell {

    static let identifier = Texts.launchesCellIdentifier

    //MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var rocketImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public Methods
    func configure(item: LaunchV4Doc) {
        nameLabel.text = item.name
        dateLabel.text = item.dateUTC?.changeDateFormat()

        guard let url = item.links?.patch.small else {
            return rocketImageView.image = UIImage(named: "no_image")
        }

        rocketImageView.kf.setImage(with: URL(string: url))
    }
}

// MARK: - Private Methods
private extension LaunchesCell {
    func configureViews() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.3
    }
}

