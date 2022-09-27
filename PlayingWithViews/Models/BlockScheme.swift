//
//  BlockScheme.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

class BlockScheme: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case figures
    }
    
    var name: String
    var figures: FigureList
    var isNew: Bool
    
    init() {
        name = ""
        figures = FigureList()
        isNew = true
    }
    
    // Decodable
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let figures = try FigureList(from: decoder)
        self.figures = figures
        isNew = false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try figures.encode(to: encoder)
    }
    
    //
    
    func addFigure(with type: FigureType) -> Figure {
        return figures.addFigure(with: type)
    }
    
    func remove(figure: Figure) throws {
        try figures.remove(figure: figure)
    }
    
}

struct FigureList: Codable {
    
    enum CodingKeys: CodingKey {
        case figures
    }
    
    enum FigureTypes: CodingKey {
        case type
    }
    
    var items: [Figure]
    
    init() {
        items = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var items: [Figure] = []
        
        let figures = try container.nestedUnkeyedContainer(forKey: .figures)
        
        var figuresArray = figures
        var figureDecoder = figuresArray
        while !figuresArray.isAtEnd {
            let figure = try figuresArray.nestedContainer(keyedBy: FigureTypes.self)
            let type = try figure.decode(FigureType.self, forKey: .type)
            
            switch type {
            case .square:
                items.append(try figureDecoder.decode(SquareFigure.self))
            case .rectangle:
                items.append(try figureDecoder.decode(RectangleFigure.self))
            case .circle:
                items.append(try figureDecoder.decode(CircleFigure.self))
            case .arrow:
                items.append(try figureDecoder.decode(ArrowFigure.self))
            }
        }
        
        self.items = items
    }
    
    func encode(to encoder: Encoder) throws {
//        var container = encoder.unkeyedContainer()
//        try container.encode(contentsOf: items)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .figures)
    }
    
    //
    
    mutating func addFigure(with type: FigureType) -> Figure {
        let figure = FigureFactoryImpl().makeEmptyFigure(with: type)
        items.append(figure)
        
        return figure
    }
    
    mutating func remove(figure: Figure) throws {
        guard let index = items.firstIndex(of: figure) else {
            throw FigureError.notFound
        }
        items.remove(at: index)
    }
    
}
