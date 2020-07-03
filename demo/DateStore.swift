//
//  DateStore.swift
//  demo
//
//  Created by Emin on 1.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine
class DateStore: ObservableObject {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    let willChange = PassthroughSubject<Void, Never>()

    var selectedDate: Date = UserDefaults.selectedDate {
        willSet {
            UserDefaults.selectedDate = newValue

            willChange.send()
        }
    }
}
