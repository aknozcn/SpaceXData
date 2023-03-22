//
//  DetailViewController.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, Storyboardable {

    // MARK: - IBOutlets
    @IBOutlet private weak var youtubeView: UIView!
    @IBOutlet private weak var pressKitView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var rocketImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Variables
    private let viewModel = DetailViewModel(apiManager: APIManager())

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureCollectionView()
        
        Loading.shared.show()
        viewModel.delegate = self
        viewModel.fetchLaunch(id: viewModel.id)
        titleLabel.text = viewModel.title
    }
    
    // MARK: - Actions
    @IBAction private func youtubeButtonClicked(_ sender: UIButton) {
        let youTubeId = viewModel.docs?.links?.youtubeId
        
        guard let youtubeId = youTubeId else {
            return
        }
        
        let url = Environment.youtubeURL + youtubeId
        openBrowser(url: url)
    }
    
    @IBAction private func pressKitButtonClicked(_ sender: UIButton) {
        let presskit = viewModel.docs?.links?.presskit
        
        guard let url = presskit else {
            return
        }
        
        openBrowser(url: url)
    }
    
    // MARK: - Public Methods
    func setId(id: String) {
        viewModel.id = id
    }
    
    func setTitle(title: String) {
        viewModel.title = title
    }
}

// MARK: - Private Methods
private extension DetailViewController {
    func configureViews() {
        youtubeView.layer.cornerRadius = 8
        youtubeView.layer.borderWidth = 0.3
        youtubeView.layer.borderColor = UIColor.lightGray.cgColor

        pressKitView.layer.cornerRadius = 8
        pressKitView.layer.borderWidth = 0.3
        pressKitView.layer.borderColor = UIColor.lightGray.cgColor
    }

    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: LaunchInfoCell.identifier, bundle: nil), forCellWithReuseIdentifier: LaunchInfoCell.identifier)
    }

    func openBrowser(url: String) {
        guard let url = URL(string: url) else {
            return
        }

        UIApplication.shared.open(url)
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func setLabels() {
        nameLabel.text = viewModel.docs?.name
        dateLabel.text = viewModel.docs?.dateUTC?.changeDateFormat()
    }

    func setImageView() {
        guard let imageUrl = viewModel.docs?.links?.patch.small else {
            rocketImageView.image = UIImage(named: "no_image")
            return
        }
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        rocketImageView.kf.setImage(with: url)
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.valueCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchInfoCell.identifier, for: indexPath) as? LaunchInfoCell else {
            return UICollectionViewCell()
        }
 
        let title = viewModel.launchInfoTitles[indexPath.row]
        
        if let value = viewModel.launchInfoValues?[safe: indexPath.row] {
            cell.configure(title: title.rawValue, value: "\(value)")
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width / 2, height: bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func launchFetched() {
        reloadData()
        setLabels()
        setImageView()
        Loading.shared.hide()
    }
}
