//
//  UserDefaultsExtension.swift
//  demo
//
//  Created by Emin on 1.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

extension UserDefaults {

    static var selectedDate: Date {
        get {
           
            let now = DateStore.dateFormatter.string(from: Date())
            let fetchedDateString = UserDefaults.standard.string(forKey: "selectedDate") ?? now
            return fetchedDateString.toDate(dateFormat: "dd.MM.yyyy")

        }
        set {
            let str = newValue.toString(dateFornat: "dd.MM.yyyy")
            UserDefaults.standard.set(str, forKey: "selectedDate")
            
        }
    }
    
    
    
}
