//
//  DateView.swift
//  demo
//
//  Created by Emin on 29.06.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct DateView: View {
    var text: String
    var body: some View {
        
        HStack {
            Spacer()
            Text(self.text)
                .fontWeight(.bold)
                .font(.system(size: 40))
                .foregroundColor(.white)
            Spacer()
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(text: "te")
    }
}
