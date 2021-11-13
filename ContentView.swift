//
//  ContentView.swift
//  Football Predictor
//
//  Created by Brendan Alm on 10/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var allTeamData: [Team] = []
    @State var canConnect = true
    @State var weekNum = 0
    @State var lastNum = 0
    
    // pull data from api
    func getAllTeamData() {
        let urlString = "https://football-odds-predictor.herokuapp.com/api/v1/football-stats/teams/all?week=\(weekNum + 6)"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) {data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([Team].self, from: data)
                        
                        // store decoded data
                        self.allTeamData = decodedData
                        canConnect = true
                    } catch {
                        print("Error something went wrong")
                        canConnect = false
                    }
                }
                else {
                    canConnect = false
                }
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Pick Week:", selection: $weekNum) {
                    ForEach(6..<19) {
                        Text("Week \($0)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Button {
                    getAllTeamData()
                    print("\(weekNum + 6)")
                } label: {
                Text("Reload")
                    .frame(width: 280, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20, weight: .bold))
                    .cornerRadius(10)
                }
                ForEach(allTeamData, id: \.self) { team in
                    // add each team to the list
                    teamLink(name: team.name,
                             winPct: team.oddsAvg,
                             opponent: team.opponent,
                             moneyline: getMLineAvg(mline: team.mline),
                             mlines: team.mline,
                             record: team.record,
                             cbsPred: team.cbs_pred)
                }
                
                // if app cannot connect to the api tell the user
                if canConnect == false {
                    Text("Cannot connect to server")
                    Button {
                        getAllTeamData()
                    } label: {
                    Text("Reload")
                        .frame(width: 280, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                    }
                }
                
            }
            .multilineTextAlignment(.center)
            .navigationTitle("Teams")
            .onAppear {
                getAllTeamData()
            }
        }.accentColor(Color.white)
    }
}




struct teamData: View {
    var name: String
    
    var mLines: [String]
    var record: String
    var cbsPred: Int
    
    var body: some View {
        ZStack {
            // create background with the color of the team
            LinearGradient(colors: [colorFromName(team: name), .gray],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            VStack {
                Text("\(name)")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .medium))
                    .padding()
                
                VStack {
                    Text("Moneylines")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .medium))
                        .underline()
                        
                    HStack {
                        ForEach(mLines, id: \.self) { m in
                            Text(m)
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, weight: .medium))
                                
                        }
                    }
                }.padding()
                
                VStack {
                    Text("Record")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .medium))
                        .underline()
                    Text("\(record)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .medium))
                }.padding()
                
                VStack {
                    Text("CBS Prediction")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .medium))
                        .underline()
                    Text("\(cbsPred)-\(abs(8 - cbsPred))")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .medium))
                    
                }
                
                Image("\(name)-logo")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct teamLink: View {
    
    var name: String
    var winPct: Double
    var opponent: String
    var moneyline: String
    var mlines: [String]
    var record: String
    var cbsPred: Int
    
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 22, weight: .bold))
                .cornerRadius(10)
            
            // move to a view for the team if clicked on
            NavigationLink(destination: TeamView(name: self.name,
                                                 winPct: self.winPct,
                                                 oppName: self.opponent,
                                                 moneyLine: self.moneyline,
                                                 mlines: self.mlines,
                                                 record: self.record,
                                                 cbsPred:
                                            self.cbsPred)) {
                Text("\(formatDecimal(value: winPct, numDigit: 2))% Chance")
                    .font(.system(size: 18, weight: .light))
                    .cornerRadius(10)
                
                    
            }
        }
    }
        
}
