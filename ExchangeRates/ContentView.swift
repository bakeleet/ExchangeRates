//
//  ContentView.swift
//  ExchangeRates
//
//  Created by bakeleet on 23/06/2024.
//

import SwiftUI
import CalendarView


struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            CalendarView(viewModel: viewModel.calendarViewModel)
                .frame(height: viewModel.calendarHeight ?? 200.0)
            Spacer()
            Text(viewModel.selectedDate)
            Spacer()
            VStack {
                if let exchangeRateTable = viewModel.exchangeRateTable {
                    Text("Currency name: \(exchangeRateTable[0].rates[1].currency)")
                    Text("Currency code: \(exchangeRateTable[0].rates[1].code)")
                    Text("Currency rate: \(exchangeRateTable[0].rates[1].mid)")
                } else {
                    Text("No data available")
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
