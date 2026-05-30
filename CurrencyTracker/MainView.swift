//
//  ContentView.swift
//  CurrencyTracker
//
//  Created by Maksim Shyshko on 30.05.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject var currencyViewModel = CurrencyViewModel()

    var body: some View {
        VStack {
            ForEach(currencyViewModel.rates) { rate in
                            Text("\(rate.name):In\(String(format: "%.3f", rate.rateIn)) Out\(String(format: "%.3f", rate.rateOut))")
                        }
        }
        .padding()
        .task {
            await currencyViewModel.fetchRates()
        }
    }
}

#Preview {
    MainView()
}
