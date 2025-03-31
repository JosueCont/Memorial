//
//  FlyingNumber.swift
//  Memoria
//
//  Created by Josue Contreras on 30/03/25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        if number != 0 {
            Text("\(number)")
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
