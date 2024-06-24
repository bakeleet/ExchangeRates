//
//  ViewModel.swift
//  ExchangeRates
//
//  Created by bakeleet on 23/06/2024.
//

import SwiftUI
import CalendarView


final class ViewModel: ObservableObject {
    
    let calendarViewModel = CalendarViewModel()
    
    @Published var calendarHeight: CGFloat?
    @Published var exchangeRateTable: [ExchangeRatesTable]?
    @Published var selectedDate = ""
    
    init() {
        calendarViewModel.delegate = self
    }
    
    private func getTableDataTask(for date: Date) {
        Task {
            let table = await RESTManager.shared.getTable(for: date)
            if let value = table {
                await self.updateExchangeRateTable(with: value)
            }
        }
    }

    @MainActor
    private func updateExchangeRateTable(with table: [ExchangeRatesTable]) {
        exchangeRateTable = table
    }

    private func updateSelectedDate(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: date)
    }
}

extension ViewModel: CalendarObserving {

    func didTapDay(for date: Date) {
        getTableDataTask(for: date)
        updateSelectedDate(with: date)
    }
    
    func didAutoSelectInitialDay(_ date: Date) {
        getTableDataTask(for: date)
        updateSelectedDate(with: date)
    }
    
    func didSetInitialHeight(_ height: CGFloat) {
        calendarHeight = height
    }
}
