//
//  DetailViewModel.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

import Foundation

enum LaunchInfoTitle: String {
    case landingAttempt = "Landing Attempt"
    case landingSuccess = "Landing Success"
    case landingType = "Landing Type"
    case flightNumber = "Flight Number"
    case upcoming = "Upcoming"
    case datePrecision = "Date Precision"
}

protocol DetailViewModelDelegate: AnyObject {
    func launchFetched()
}

class DetailViewModel {

    // MARK: - Variables
    private let apiManager: APIManaging
    private var launchData: LaunchV4Doc?
    private var launchId: String = ""
    private var screenTitle: String = ""

    var launchInfoValues: [Any]? = []
    var launchInfoTitles: [LaunchInfoTitle] = [.landingAttempt, .landingSuccess, .landingType,
                                                .flightNumber, .upcoming, .datePrecision]

    //MARK: - Delegate
    weak var delegate: DetailViewModelDelegate?

    // MARK: - Initialization
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }

    // MARK: - Properties
    var valueCount: Int {
        return launchInfoValues?.count ?? 0
    }
    
    var docs: LaunchV4Doc? {
        return launchData
    }
    
    var id: String {
        get {
            return launchId
        }
        set {
            launchId = newValue
        }
    }
    
    var title: String {
        get {
            return screenTitle
        }
        set {
            screenTitle = newValue
        }
    }
    
    // MARK: - Public Methods
    func fetchLaunch(id: String) {
        apiManager.fetchLaunch(id: id) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.launchData = data
                self.setLaunchInfoValues(data: data)
                self.delegate?.launchFetched()
            case .failure(let error):
                print("Error fetching launch: \(error)")
            }
        }
    }
}

// MARK: - Private Methods
private extension DetailViewModel {
    func setLaunchInfoValues(data: LaunchV4Doc) {
        let core = data.cores?.first
        let properties: [Any?] = [
            core?.landingAttempt,
            core?.landingSuccess,
            core?.landingType,
            data.flightNumber,
            data.upcoming,
            data.datePrecision
        ]

        for (index, value) in properties.enumerated() {
            self.launchInfoValues?.insert(value ?? "-", at: index)
        }
    }
}

