//
//  team.swift
//  Football Predictor
//
//  Created by Brendan Alm on 10/7/21.
//

import SwiftUI

struct Team: Decodable, Hashable {
    let cbs_pred: Int
    let mline: Array<String>
    let name: String
    let odds: Array<Double>
    let oddsAvg: Double
    let opponent: String
    let record: String
    let week: Int
}
