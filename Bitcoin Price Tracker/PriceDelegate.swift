//
//  PriceDelegate.swift
//  Bitcoin Price Tracker
//
//  Created by Moamen Hassaballah on 01/02/2022.
//

import Foundation

protocol PriceDelegate {
    func onPriceRetrieved(price: Prices)
    func onError(error: Error)
}
