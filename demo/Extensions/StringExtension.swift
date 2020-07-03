//
//  StringExtension.swift
//  demo
//
//  Created by Emin on 1.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
        
    }
}
