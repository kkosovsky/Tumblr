//
//  StringExtensions.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

extension String {

    func formatThumblrApiObjectToJson() -> String {
        let removeVariableCharsIndex = self.index(self.startIndex, offsetBy: 22)
        let substringCutBeginingChars = self.substring(from: removeVariableCharsIndex)
        let removeEndingCharsIndex = substringCutBeginingChars.index(substringCutBeginingChars.endIndex, offsetBy: -2)
        let formattedString = substringCutBeginingChars.substring(to: removeEndingCharsIndex)
        return formattedString
    }
    
        var html2AttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
                return  nil
            }
        }
        
        var html2String: String {
            return html2AttributedString?.string ?? ""
        }
    
}
