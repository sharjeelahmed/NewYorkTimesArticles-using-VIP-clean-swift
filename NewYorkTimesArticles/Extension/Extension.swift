//
//  Extension.swift
//  NewYorkTimesArticles
//
//  Created by shairjeel ahmed on 25/07/2022.
//

import Foundation
import UIKit


extension Data{
    func convertToJson()->[String:Any]? {
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
               return json
            }
        } catch let error as NSError {
        
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
        return nil
    }
}

extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "placeHolder.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "placeHolder.png")
            }
        }
    }
}

extension UIImageView{
   
// Round Image
    func roundCorner() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
    }
}
 
