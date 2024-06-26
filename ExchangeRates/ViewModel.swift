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
    @Published var exchangeRateTable: ExchangeRatesTable?
    @Published var selectedDate = ""
    @Published var effectiveDate: String?
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    init() {
        calendarViewModel.delegate = self
    }
    
    private func updateSelectedDate(with date: Date) {
        selectedDate = dateFormatter.string(from: date)
    }
    
    private func getTableDataTask(for date: Date) {
        Task {
            let table = await RESTManager.shared.getTable(for: date)
            if let value = table {
                await updateExchangeRateTable(with: value)
            }
        }
    }

    @MainActor
    private func updateExchangeRateTable(with table: [ExchangeRatesTable]) {
        guard !table.isEmpty else { return }
        exchangeRateTable = table[0]
        updateEffectiveDate(with: table[0].effectiveDate)
    }
    
    private func updateEffectiveDate(with date: Date) {
        let effectiveDateFromTable = dateFormatter.string(from: date)
        effectiveDate = (effectiveDateFromTable != selectedDate) ? "Data from: \(effectiveDateFromTable)" : nil
    }
}

extension ViewModel: CalendarObserving {

    func didTapDay(for date: Date) {
        updateSelectedDate(with: date)
        getTableDataTask(for: date)
    }
    
    func didAutoSelectInitialDay(_ date: Date) {
        updateSelectedDate(with: date)
        getTableDataTask(for: date)
    }
    
    func didSetInitialHeight(_ height: CGFloat) {
        calendarHeight = height
    }
}
