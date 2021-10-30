//
//  LineChartStyle.swift
//  
//
//  Created by Will Dale on 25/01/2021.
//

import SwiftUI

/**
 Control of the overall aesthetic of the line chart.
 
 Controls the look of the chart as a whole, not including any styling
 specific to the data set(s),
 */
public struct LineChartStyle: CTLineChartStyle {
    
    // MARK: Deprecations
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxPlacement: InfoBoxPlacement
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxContentAlignment: InfoBoxAlignment
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxValueFont: Font
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxValueColour: Color
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxDescriptionFont: Font
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxDescriptionColour: Color
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxBackgroundColour: Color
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxBorderColour: Color
    @available(*, deprecated, message: "Please use \"touchDisplay\" instead.")
    public var infoBoxBorderStyle: StrokeStyle
    
    // MARK: Properties
    public var markerType: LineMarkerType
    
    public var xAxisGridStyle: GridStyle
    
    public var xAxisLabelPosition: XAxisLabelPosistion
    public var xAxisLabelFont: Font
    public var xAxisLabelColour: Color
    public var xAxisLabelsFrom: LabelsFrom
    
    public var xAxisTitle: String?
    public var xAxisTitleFont: Font
    public var xAxisTitleColour: Color
    public var xAxisBorderColour: Color?

    public var yAxisGridStyle: GridStyle
    
    public var yAxisLabelPosition: YAxisLabelPosistion
    public var yAxisLabelFont: Font
    public var yAxisLabelColour: Color
    public var yAxisNumberOfLabels: Int
    public var yAxisLabelType: YAxisLabelType
    
    public var yAxisTitle: String?
    public var yAxisTitleFont: Font
    public var yAxisTitleColour: Color
    public var yAxisBorderColour: Color?

    public var baseline: Baseline
    public var topLine: Topline
    
    public var globalAnimation: Animation
    
    // MARK: Init
    /// Model for controlling the overall aesthetic of the chart.
    /// - Parameters:
    ///   - markerType: Where the marker lines come from to meet at a specified point.
    ///
    ///   - xAxisGridStyle: Style of the vertical lines breaking up the chart.
    ///   
    ///   - xAxisLabelPosition: Location of the X axis labels - Top or Bottom.
    ///   - xAxisLabelFont: Font of the labels on the X axis.
    ///   - xAxisLabelColour: Text Colour for the labels on the X axis.
    ///   - xAxisLabelsFrom: Where the label data come from. DataPoint or xAxisLabels.
    ///
    ///   - xAxisTitle: Label to display next to the chart giving info about the axis.
    ///   - xAxisTitleFont: Font of the x axis title.
    ///   - xAxisTitleColour: Colour of the x axis title.
    ///   - xAxisBorderColour: Colour of the x axis border.
    ///
    ///   - yAxisGridStyle: Style of the horizontal lines breaking up the chart.
    ///
    ///   - yAxisLabelPosition: Location of the X axis labels - Leading or Trailing.
    ///   - yAxisLabelFont: Font of the labels on the Y axis.
    ///   - yAxisLabelColour: Text Colour for the labels on the Y axis.
    ///   - yAxisNumberOfLabels: Number Of Labels on Y Axis.
    ///   - yAxisLabelType: Option to add custom Strings to Y axis rather than auto generated numbers.
    ///
    ///   - yAxisTitle: Label to display next to the chart giving info about the axis.
    ///   - yAxisTitleFont: Font of the y axis title.
    ///   - yAxisTitleColour: Colour of the y axis title.
    ///   - yAxisBorderColour: Colour of the y axis border.
    ///
    ///   - baseline: Whether the chart is drawn from baseline of zero or the minimum datapoint value.
    ///   - topLine: Where to finish drawing the chart from. Data set maximum or custom.
    ///
    ///   - globalAnimation: Global control of animations.
    public init(
        markerType: LineMarkerType = .indicator(style: DotStyle()),
        
        xAxisGridStyle: GridStyle = GridStyle(),
        
        xAxisLabelPosition: XAxisLabelPosistion = .bottom,
        xAxisLabelFont: Font = .caption,
        xAxisLabelColour: Color = Color.primary,
        xAxisLabelsFrom: LabelsFrom = .dataPoint(rotation: .degrees(0)),
        
        xAxisTitle: String? = nil,
        xAxisTitleFont: Font = .caption,
        xAxisTitleColour: Color = .primary,
        xAxisBorderColour: Color? = nil,

        yAxisGridStyle: GridStyle = GridStyle(),
        
        yAxisLabelPosition: YAxisLabelPosistion = .leading,
        yAxisLabelFont: Font = .caption,
        yAxisLabelColour: Color = Color.primary,
        yAxisNumberOfLabels: Int = 10,
        yAxisLabelType: YAxisLabelType = .numeric,
        
        yAxisTitle: String? = nil,
        yAxisTitleFont: Font = .caption,
        yAxisTitleColour: Color = .primary,
        yAxisBorderColour: Color? = nil,

        baseline: Baseline = .minimumValue,
        topLine: Topline = .maximumValue,
        
        globalAnimation: Animation = Animation.linear(duration: 1)
    ) {
        self.markerType = markerType
        
        self.xAxisGridStyle = xAxisGridStyle
        
        self.xAxisLabelPosition = xAxisLabelPosition
        self.xAxisLabelFont = xAxisLabelFont
        self.xAxisLabelsFrom = xAxisLabelsFrom
        self.xAxisLabelColour = xAxisLabelColour
        
        self.xAxisTitle = xAxisTitle
        self.xAxisTitleFont = xAxisTitleFont
        self.xAxisTitleColour = xAxisTitleColour
        self.xAxisBorderColour = xAxisBorderColour
        
        self.yAxisGridStyle = yAxisGridStyle
        
        self.yAxisLabelPosition = yAxisLabelPosition
        self.yAxisNumberOfLabels = yAxisNumberOfLabels
        self.yAxisLabelFont = yAxisLabelFont
        self.yAxisLabelColour = yAxisLabelColour
        self.yAxisLabelType = yAxisLabelType
        
        self.yAxisTitle = yAxisTitle
        self.yAxisTitleFont = yAxisTitleFont
        self.yAxisTitleColour = yAxisTitleColour
        self.yAxisBorderColour = yAxisBorderColour

        self.baseline = baseline
        self.topLine = topLine
        
        self.globalAnimation = globalAnimation
        
        self.infoBoxPlacement = .floating
        self.infoBoxContentAlignment = .vertical
        self.infoBoxValueFont = .title3
        self.infoBoxValueColour = Color.primary
        self.infoBoxDescriptionFont = .caption
        self.infoBoxDescriptionColour = Color.primary
        self.infoBoxBackgroundColour = Color.systemsBackground
        self.infoBoxBorderColour = Color.clear
        self.infoBoxBorderStyle = StrokeStyle(lineWidth: 0)
    }
}
