//
//  Extension.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//
//
import UIKit

func imageToData(_ title: String) -> Data? {
  guard let img = UIImage(named: title) else { return nil }
  return img.jpegData(compressionQuality: 1)
}

class Alert {
    static func createAlertController(title: String, message: String) -> UIAlertController {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
         let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
             alert.dismiss(animated: true, completion: nil)
         }
         
         alert.addAction(okAction)
         
         return alert
     }
}

extension UIImage {
    
    var base64: String? {
        self.pngData()?.base64EncodedString()
    }
}

extension String {
    
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
