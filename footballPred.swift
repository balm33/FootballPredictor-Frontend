//
//  footballPred.swift
//  Football Predictor
//
//  Created by Brendan Alm on 10/7/21.
//

import Foundation
import CoreImage
import SwiftUI

/// Rounds a Double to a determined number of decimal places and converts to a String
/// - Parameters:
///   - value: the raw value that needs to be trimmed
///   - numDigit: the number of decimal places
/// - Returns: the converted number in String format
func formatDecimal(value: Double, numDigit: Int) -> String {
    
    
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = numDigit
    formatter.minimumFractionDigits = numDigit
    if let formattedString = formatter.string(for: value) {
        return formattedString
    }
    else {
        return ""
    }
}

/// Gets the average of all numbers in mline and makes sure that the + or - remains
/// - Parameter mline: the list of moneylines
/// - Returns: the average moneyline with a leading + or -
func getMLineAvg(mline: [String]) -> String {
    var add = 0
    let len = mline.count
    
    for i in mline {
        let k = Int(i) ?? 0
        add += k
    }
    
    var avg = 0
    
    if len > 0 {
        avg = add / len
    }
    
    if avg > 0 {
        return "+\(String(avg))"
    }
    else {
        return String(avg)
    }
}

/// Finds the Color that is used to represent a specific team
/// - Parameter team: the name of the team whose color is required
/// - Returns: a Color that can be used to represent that specific team
func colorFromName(team: String) -> Color {
    switch team {
    case "Arizona Cardinals":
        return Color.red
    case "Atlanta Falcons":
        return Color.red
    case "Baltimore Ravens":
        return Color.purple
    case "Buffalo Bills":
        return Color.blue
    case "Carolina Panthers":
        return Color.blue
    case "Chicago Bears":
        return Color("Navy")
    case "Cincinnati Bengals":
        return Color("Dark Orange")
    case "Cleveland Browns":
        return Color("Dark Orange")
    case "Dallas Cowboys":
        return Color("Navy")
    case "Denver Broncos":
        return Color("Dark Orange")
    case "Detroit Lions":
        return Color.blue
    case "Green Bay Packers":
        return Color("Dark Green")
    case "Houston Texans":
        return Color("Navy")
    case "Indianapolis Colts":
        return Color.blue
    case "Jacksonville Jaguars":
        return Color.yellow
    case "Kansas City Chiefs":
        return Color.red
    case "Las Vegas Raiders":
        return Color.black
    case "Los Angeles Chargers":
        return Color.blue
    case "Los Angeles Rams":
        return Color.blue
    case "Miami Dolphins":
        return Color("Aqua")
    case "Minnesota Vikings":
        return Color("Dark Purple")
    case "New England Patriots":
        return Color("Navy")
    case "New Orleans Saints":
        return Color.yellow
    case "New York Giants":
        return Color("Navy")
    case "New York Jets":
        return Color("Dark Green")
    case "Philadelphia Eagles":
        return Color("Midnight Green")
    case "Pittsburgh Steelers":
        return Color.black
    case "San Francisco 49ers":
        return Color.red
    case "Seattle Seahawks":
        return Color("Navy")
    case "Tampa Bay Buccaneers":
            return Color.red
    case "Tennesee Titans":
        return Color("Navy")
    case "Washington Football Team":
        return Color("Maroon")
    
    default:
        return Color.gray
    }
}
