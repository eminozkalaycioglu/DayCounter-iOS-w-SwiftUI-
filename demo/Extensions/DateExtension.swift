//
//  DateExtension.swift
//  demo
//
//  Created by Emin on 1.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFornat: String) -> String {
        let df = DateFormatter()
        df.dateFormat = dateFornat
        let str = df.string(from: self)
        return str
    }
}
