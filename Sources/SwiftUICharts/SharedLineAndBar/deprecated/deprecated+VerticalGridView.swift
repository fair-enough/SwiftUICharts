//
//  deprecated+VerticalGridView.swift
//  
//
//  Created by Will Dale on 08/02/2021.
//

import SwiftUI

@available(*, deprecated, message: "Use \".grid\" instead")
internal struct VerticalGridView<ChartData>: View where ChartData: CTChartData {
    
    @ObservedObject private var chartData: ChartData
    private var style: GridStyle
    @State private var startAnimation: Bool
    
    internal init(
        chartData: ChartData,
        style: GridStyle
    ) {
        self.chartData = chartData
        self.style = style
        self._startAnimation = State<Bool>(initialValue: chartData.shouldAnimate ? false : true)
    }
    
    var body: some View {
        VerticalGridShape()
            .trim(to: startAnimation ? 1 : 0)
            .stroke(style.lineColour,
                    style: StrokeStyle(lineWidth: style.lineWidth,
                                       dash: style.dash,
                                       dashPhase: style.dashPhase))
            .frame(width: style.lineWidth)
            .animateOnAppear(using: .linear) {
                self.startAnimation = true
            }
            .onDisappear {
                self.startAnimation = false
            }
    }
}