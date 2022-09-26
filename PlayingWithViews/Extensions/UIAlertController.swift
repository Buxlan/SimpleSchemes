//
//  UIAlertController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import UIKit

enum AlertError: Error {
    case cancelled
}

extension UIAlertController {
    
    static func makeInputTextAlert(title: String?,
                                   message: String?,
                                   prefferedStyle: UIAlertController.Style = .alert,
                                   okButtonTitle: String = "READY".localized(),
                                   cancelButtonTitle: String = "CANCEL".localized(),
                                   textFieldPlaceholder: String = "",
                                   onComplete: @escaping (Result<String?, AlertError>) -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = textFieldPlaceholder
        }
        
        let saveAction = UIAlertAction(title: okButtonTitle, style: .default) { [unowned alertController] _ in
            let textField = alertController.textFields![0] as UITextField
            onComplete(.success(textField.text))
        }
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default) { _ in
            onComplete(.failure(.cancelled))
        }
                
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        return alertController
    }
    
}
