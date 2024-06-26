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
            Text(viewModel.selectedDate)
                .font(.headline)
            if let effectiveDate = viewModel.effectiveDate {
                Text(effectiveDate)
                    .font(.subheadline)
            }
            ScrollView {
                LazyVStack(spacing: 10) {
                    if let exchangeRateTable = viewModel.exchangeRateTable {
                        ForEach(exchangeRateTable.rates, id: \.code) { rate in
                            VStack {
                                Text(rate.currency)
                                HStack {
                                    Spacer()
                                    Text(rate.code)
                                    Spacer()
                                    Text("\(rate.mid)")
                                    Spacer()
                                }
                                .padding(10)
                            }
                            .padding(10)
                            .background(content: {
                                Color.blue.opacity(0.15)
                                    .cornerRadius(25)
                            })
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
