//
//  teamView.swift
//  Football Predictor
//
//  Created by Brendan Alm on 10/10/21.
//

import SwiftUI

struct TeamView: View {
    
    @State private var showData = false
    
    var name: String
    var winPct: Double
    var oppName: String
    var moneyLine: String
    var mlines: [String]
    var record: String
    var cbsPred: Int
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [colorFromName(team: name), .gray, colorFromName(team: oppName)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 2) {
                setTeamName(name: self.name)
                setTeamLogo(team: self.name)
            
                Text("VS")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Color.white)
                    .padding()
                setOpponentName(name: self.oppName)
                setTeamLogo(team: self.oppName)
                
                setWinChance(percent: self.winPct)
                setMoneyline(moneyline: moneyLine)
                    .padding()
                Button {
                    self.showData.toggle()
                } label: {
                    Text("View Data")
                        .frame(width: 280, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                }.sheet(isPresented: $showData){
                    teamData(name: self.name, mLines: self.mlines, record: self.record, cbsPred: cbsPred)
                }
                
                
            }
        }
    }
}

struct setWinChance: View {

    var percent: Double
    
    var body: some View {
        VStack {
            Text("\(formatDecimal(value: percent, numDigit: 2))%")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(Color.white)
            Text("Chance of winning")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color.white)
        }
    }
}

struct setMoneyline: View {
    
    var moneyline: String
    
    var body: some View {
        VStack {
            Text("\(moneyline)")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(Color.white)
            Text("Moneyline")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color.white)
        }
    }
}

struct setTeamName: View {
    
    var name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(Color.white)
    }
}

struct setTeamLogo: View {
    
    var team: String
    
    var body: some View {
        Image("\(team)-logo")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 180)
    }
}

struct setOpponentName: View {
    
    var name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 26, weight: .medium))
            .foregroundColor(Color.white)
    }
}
