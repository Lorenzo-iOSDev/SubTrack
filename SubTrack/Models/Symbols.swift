//
//  Symbols.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 20/07/21.
//

import Foundation

enum Symbols: String, CaseIterable, Codable{
    case TV = "tv"
    case Music = "headphones"
    case Gaming = "gamecontroller"
    case Book = "book"
    case Podcast = "radio"
    case Groceries = "cart"
    case Educational = "graduationcap"
    case Box = "shippingbox"
    case Film = "film"
    case VPN = "lock.shield"
    case Server = "server.rack"
    case Network = "network"
}

extension Symbols {
    func convertToInt() -> Int {
        switch self {
        case .TV:
            return 0
        case .Music:
            return 1
        case .Gaming:
            return 2
        case .Book:
            return 3
        case .Podcast:
            return 4
        case .Groceries:
            return 5
        case .Educational:
            return 6
        case .Box:
            return 7
        case .Film:
            return 8
        case .VPN:
            return 9
        case .Server:
            return 10
        case .Network:
            return 11
        }
    }
}
