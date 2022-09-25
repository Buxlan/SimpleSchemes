//
//  BlockSchemeError.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

enum BlockSchemeSavingError: Error {
    case nameIsEmpty
    case alreadyExists
    
    var description: String {
        switch self {
        case .nameIsEmpty:
            return "BLOCK_SCHEME.ERROR.SAVING.NAME_IS_EMPTY".localized()
        case .alreadyExists:
            return "BLOCK_SCHEME.ERROR.SAVING.ALREADY_EXISTS".localized()
        }
    }
}

enum BlockSchemeLoadingError: Error {
    case nameIsEmpty
    case fileNotExists
    case dataIsNil
    
    var description: String {
        switch self {
        case .nameIsEmpty:
            return "BLOCK_SCHEME.ERROR.LOADING.NAME_IS_EMPTY".localized()
        case .fileNotExists:
            return "BLOCK_SCHEME.ERROR.LOADING.FILE_NOT_EXISTS".localized()
        case .dataIsNil:
            return "BLOCK_SCHEME.ERROR.LOADING.DATA_IS_NIL".localized()
        }
    }
}
