//
//  CurrencyViewModel.swift
//  CurrencyTracker
//
//  Created by Maksim Shyshko on 30.05.2026.
//

import Foundation
import Combine

@MainActor
class CurrencyViewModel: ObservableObject {
    @Published var rates: [CurrencyRate] = []

    func fetchRates() async {
        guard let url = URL(string: "https://belarusbank.by/api/kursExchange") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponses = try JSONDecoder().decode([CurrencyRatesResponse].self, from: data)
            self.rates = decodedResponses.first?.rates ?? []

        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
}
