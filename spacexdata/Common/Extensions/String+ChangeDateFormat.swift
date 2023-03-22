//
//  String+ChangeDateFormat.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import Foundation

extension String {
    func changeDateFormat() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = inputDateFormatter.date(from: self)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return outputDateFormatter.string(from: date ?? Date())
    }
}
