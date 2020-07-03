//
//  ThinText.swift
//  demo
//
//  Created by Emin on 28.06.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct ThinText: View {
    var text: String
    var body: some View {
        HStack {
            Spacer()
            Text(self.text)
                .fontWeight(.light)
                .font(.system(size: 20))
            Spacer()
        }
    }
}

struct ThinText_Previews: PreviewProvider {
    static var previews: some View {
        ThinText(text: "asd")
    }
}
