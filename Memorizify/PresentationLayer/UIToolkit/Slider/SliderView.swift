//
//  SliderView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 20.04.2024.
//

import SwiftUI

struct SliderView: View {
    
    private var title: String
    private var range: ClosedRange<Double>
    
    private var valueBinding: Binding<Double>

    init(title: String, range: ClosedRange<Double>, valueBinding: Binding<Double>) {
        self.title = title
        self.range = range
        self.valueBinding = valueBinding
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Text("\(Int(valueBinding.wrappedValue))")
            }
            Slider(value: valueBinding, in: range, step: 1)
                .tint(Color("primary_color"))
        }
    }
}

#Preview {
    SliderView(
        title: "",
        range: 0.0...1.1,
        valueBinding: Binding<Double>(get: { return 0.0 }, set: { _, _ in })
    )
}
