//
//  PaymentFrequency.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 20/07/21.
//

import Foundation

enum PaymentFrequency: String, CaseIterable, Codable {
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    case Quarterly = "Quarterly"
    case BiAnnually = "Bi-Annual"
    case Annually = "Annual"
}

extension PaymentFrequency {
    func convertToInt() -> Int {
        switch self {
        case .Weekly:
            return 0
        case .Monthly:
            return 1
        case .Quarterly:
            return 2
        case .BiAnnually:
            return 3
        case .Annually:
            return 4
        }
    }
}
