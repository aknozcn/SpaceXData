//
//  MainViewModel.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
    func launchesFetched()
}

class MainViewModel {

    //MARK: - Variables
    private let apiManager: APIManaging
    private var totalPages: Int = 1
    private var currentPage: Int = 1
    private var listLaunches: [LaunchV4Doc] = []

    //MARK: - Delegate
    weak var delegate: MainViewModelDelegate?

    // MARK: - Initialization
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    // MARK: - Properties
    var docs: [LaunchV4Doc] {
        return listLaunches
    }
    
    var currentPageNumber: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }

    // MARK: - Public Methods
    func clearListLaunches() {
        listLaunches.removeAll()
    }

    func fetchUpcomingLaunches(page: Int) {
        fetchLaunches(page: page, fetchMethod: apiManager.fetchUpcomingLaunches)
    }

    func fetchPastLaunches(page: Int) {
        fetchLaunches(page: page, fetchMethod: apiManager.fetchPastLaunches)
    }

    func pagePlusOne() {
        currentPage = currentPage + 1
    }

    func isLoadMoreData(_ indexPath: IndexPath) -> Bool {
        currentPage <= totalPages && indexPath.row == listLaunches.count - 1
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    typealias LaunchesFetchCompletion = (Result<LaunchV4Response, Error>) -> Void
    
    func fetchLaunches(page: Int, fetchMethod: (Int, @escaping LaunchesFetchCompletion) -> Void) {
        fetchMethod(page) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.listLaunches.append(contentsOf: data.docs ?? [])
                self.totalPages = data.totalPages ?? 1
                self.delegate?.launchesFetched()
            case .failure(let error):
                print("Error fetching launches: \(error)")
            }
        }
    }
}
