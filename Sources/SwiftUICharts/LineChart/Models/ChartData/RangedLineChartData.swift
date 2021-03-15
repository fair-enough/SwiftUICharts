//
//  RangedLineChartData.swift
//  
//
//  Created by Will Dale on 01/03/2021.
//

import SwiftUI

/**
 Data for drawing and styling ranged line chart.
 
 This model contains the data and styling information for a ranged line chart.
 */
public final class RangedLineChartData: CTLineChartDataProtocol {
    
    // MARK: Properties
    public let id   : UUID  = UUID()
    
    @Published public var dataSets      : RangedLineDataSet
    @Published public var metadata      : ChartMetadata
    @Published public var xAxisLabels   : [String]?
    @Published public var chartStyle    : LineChartStyle
    @Published public var legends       : [LegendData]
    @Published public var viewData      : ChartViewData
    @Published public var infoView      : InfoViewData<RangedLineChartDataPoint> = InfoViewData()
    
    public var noDataText   : Text
    public var chartType    : (chartType: ChartType, dataSetType: DataSetType)
        
    // MARK: Initializer
    /// Initialises a ranged line chart.
    ///
    /// - Parameters:
    ///   - dataSets: Data to draw and style a line.
    ///   - metadata: Data model containing the charts Title, Subtitle and the Title for Legend.
    ///   - xAxisLabels: Labels for the X axis instead of the labels in the data points.
    ///   - chartStyle: The style data for the aesthetic of the chart.
    ///   - noDataText: Customisable Text to display when where is not enough data to draw the chart.
    public init(dataSets    : RangedLineDataSet,
                metadata    : ChartMetadata     = ChartMetadata(),
                xAxisLabels : [String]?         = nil,
                chartStyle  : LineChartStyle    = LineChartStyle(),
                noDataText  : Text              = Text("No Data")
    ) {
        self.dataSets       = dataSets
        self.metadata       = metadata
        self.xAxisLabels    = xAxisLabels
        self.chartStyle     = chartStyle
        self.noDataText     = noDataText
        self.legends        = [LegendData]()
        self.viewData       = ChartViewData()
        self.chartType      = (chartType: .line, dataSetType: .single)
        
        self.setupLegends()
        self.setupRangeLegends()
    }
    
    public var average  : Double {
        let sum = dataSets.dataPoints.reduce(0) { $0 + $1.value }
        return sum / Double(dataSets.dataPoints.count)
    }
    
    // MARK: Labels
    public func getXAxisLabels() -> some View {
        Group {
            switch self.chartStyle.xAxisLabelsFrom {
            case .dataPoint(let angle):
                
                HStack(spacing: 0) {
                    ForEach(dataSets.dataPoints) { data in
                        YAxisDataPointCell(chartData: self, label: data.wrappedXAxisLabel, rotationAngle: angle)
                            .foregroundColor(self.chartStyle.xAxisLabelColour)
                            .accessibilityLabel(Text("X Axis Label"))
                            .accessibilityValue(Text("\(data.wrappedXAxisLabel)"))
                        if data != self.dataSets.dataPoints[self.dataSets.dataPoints.count - 1] {
                            Spacer()
                                .frame(minWidth: 0, maxWidth: 500)
                        }
                    }
                }
                .padding(.horizontal, -4)
                
            case .chartData:
                if let labelArray = self.xAxisLabels {
                    HStack(spacing: 0) {
                        ForEach(labelArray, id: \.self) { data in
                            YAxisChartDataCell(chartData: self, label: data)
                                .foregroundColor(self.chartStyle.xAxisLabelColour)
                                .accessibilityLabel(Text("X Axis Label"))
                                .accessibilityValue(Text("\(data)"))
                            if data != labelArray[labelArray.count - 1] {
                                Spacer()
                                    .frame(minWidth: 0, maxWidth: 500)
                            }
                        }
                    }
                    .padding(.horizontal, -4)
                }
            }
        }
    }

    // MARK: Points
    public func getPointMarker() -> some View {
        PointsSubView(dataSets  : dataSets,
                      minValue  : self.minValue,
                      range     : self.range,
                      animation : self.chartStyle.globalAnimation,
                      isFilled  : false)
    }

    public func getTouchInteraction(touchLocation: CGPoint, chartSize: CGRect) -> some View {
        self.markerSubView(dataSet: dataSets,
                           dataPoints: dataSets.dataPoints,
                           lineType: dataSets.style.lineType,
                           touchLocation: touchLocation,
                           chartSize: chartSize)
    }
    
    public func getPointLocation(dataSet: RangedLineDataSet, touchLocation: CGPoint, chartSize: CGRect) -> CGPoint? {
        
        let minValue : Double = self.minValue
        let range    : Double = self.range
        
        let xSection : CGFloat = chartSize.width / CGFloat(dataSet.dataPoints.count - 1)
        let ySection : CGFloat = chartSize.height / CGFloat(range)
        
        let index    : Int     = Int((touchLocation.x + (xSection / 2)) / xSection)
        if index >= 0 && index < dataSet.dataPoints.count {
            if !dataSet.style.ignoreZero {
                return CGPoint(x: CGFloat(index) * xSection,
                               y: (CGFloat(dataSet.dataPoints[index].value - minValue) * -ySection) + chartSize.height)
            } else {
                if dataSet.dataPoints[index].value != 0 {
                    return CGPoint(x: CGFloat(index) * xSection,
                                   y: (CGFloat(dataSet.dataPoints[index].value - minValue) * -ySection) + chartSize.height)
                }
            }
        }
        return nil
    }
    
    public func getDataPoint(touchLocation: CGPoint, chartSize: CGRect) {
        var points      : [RangedLineChartDataPoint] = []
        let xSection    : CGFloat = chartSize.width / CGFloat(dataSets.dataPoints.count - 1)
        let index       = Int((touchLocation.x + (xSection / 2)) / xSection)
        if index >= 0 && index < dataSets.dataPoints.count {
            
            if !dataSets.style.ignoreZero {
                var dataPoint = dataSets.dataPoints[index]
                dataPoint.legendTag = dataSets.legendTitle
                points.append(dataPoint)
            } else {
                if dataSets.dataPoints[index].value != 0 {
                    var dataPoint = dataSets.dataPoints[index]
                    dataPoint.legendTag = dataSets.legendTitle
                    points.append(dataPoint)
                }
            }
        }
        self.infoView.touchOverlayInfo = points
    }
    
    public typealias Set       = RangedLineDataSet
    public typealias DataPoint = RangedLineChartDataPoint
}