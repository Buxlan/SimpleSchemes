//
//  ConfigurableFigure.swift
//  SimpleSchemes
//
//  Created by Sergey Bush bushmakin@outlook.com on 02.10.2022.
//

protocol ConfigurableFigure {
    associatedtype DataType
    func configure(with: DataType)
    
}

protocol FigureConfigurator {
    func configure(figure: Figure)
}

final class FigureConfiguratorImpl<FigureType: ConfigurableFigure, DataType>: FigureConfigurator where FigureType.DataType == DataType, FigureType: Figure {
    
    private let data: DataType
    
    init(data: DataType) {
        self.data = data
    }
    
    func configure(figure: Figure) {
        if let figure = figure as? FigureType {
            figure.configure(with: data)
        }
    }
    
}

typealias SquareConfigurator = FigureConfiguratorImpl<SquareFigure, DefaultFigureConfigurationProtocol>
typealias RectangleConfigurator = FigureConfiguratorImpl<RectangleFigure, DefaultFigureConfigurationProtocol>
typealias CircleConfigurator = FigureConfiguratorImpl<CircleFigure, DefaultFigureConfigurationProtocol>
typealias ArrowConfigurator = FigureConfiguratorImpl<ArrowFigure, BackgroundColorProviding>
