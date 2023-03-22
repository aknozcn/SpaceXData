//
//  MainViewController.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!

    // MARK: - Variables
    private let viewModel = MainViewModel(apiManager: APIManager())
    private let refreshControl = UIRefreshControl()

    // MARK: - Properties
    private var isUpcomingLaunchSelected: Bool = true {
        didSet {
            resetViewModel()
            isUpcomingLaunchSelected ? fetchUpcomingLaunches() : fetchPastLaunches()
        }
    }

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRefreshControl()
        configureTableView()
        viewModel.delegate = self
        Loading.shared.show()
        viewModel.fetchUpcomingLaunches(page: viewModel.currentPageNumber)
    }

    // MARK: - Actions
    @objc private func refresh(_ sender: AnyObject) {
        resetViewModel()
        isUpcomingLaunchSelected = segmentControl.selectedSegmentIndex == 0
        refreshControl.endRefreshing()
    }

    @IBAction private func segmentControllerClicked(_ sender: UISegmentedControl) {
        Loading.shared.show()
        isUpcomingLaunchSelected = sender.selectedSegmentIndex == 0
        scrollToFirstRow()
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: Texts.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: LaunchesCell.identifier, bundle: nil), forCellReuseIdentifier: LaunchesCell.identifier)
        tableView.rowHeight = 70
        tableView.addSubview(refreshControl)
    }

    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func resetViewModel() {
        viewModel.clearListLaunches()
        viewModel.currentPageNumber = 1
    }

    func fetchUpcomingLaunches() {
        viewModel.fetchUpcomingLaunches(page: viewModel.currentPageNumber)
    }

    func fetchPastLaunches() {
        viewModel.fetchPastLaunches(page: viewModel.currentPageNumber)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController.instantiate(storyboardName: .detailScreen)
        let title = segmentControl.selectedSegmentIndex == 0 ? Texts.upComingScreenTitle : Texts.pastScreenTitle
        if let id = viewModel.docs[indexPath.row].id {
            detailViewController.setId(id: id)
            detailViewController.setTitle(title: title)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.isLoadMoreData(indexPath) else {
            return
        }
        viewModel.pagePlusOne()
        isUpcomingLaunchSelected ? fetchUpcomingLaunches() : fetchPastLaunches()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.docs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let launchesCell = tableView.dequeueReusableCell(withIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {
            return UITableViewCell()
        }

        if let item = viewModel.docs[safe: indexPath.row] {
            launchesCell.configure(item: item)
        }

        return launchesCell
    }
}

// MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    func launchesFetched() {
        tableView.reloadData()
        Loading.shared.hide()
    }
}
