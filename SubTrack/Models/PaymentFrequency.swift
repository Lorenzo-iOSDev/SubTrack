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
