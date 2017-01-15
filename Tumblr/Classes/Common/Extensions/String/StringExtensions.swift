//
//  StringExtensions.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation

extension String {

    func formatThumblrApiObjectToJson() -> String {
        let removeVariableCharsIndex = self.index(self.startIndex, offsetBy: 22)
        let substringCutBeginingChars = self.substring(from: removeVariableCharsIndex)
        let removeEndingCharsIndex = substringCutBeginingChars.index(substringCutBeginingChars.endIndex, offsetBy: -2)
        let formattedString = substringCutBeginingChars.substring(to: removeEndingCharsIndex)
        return formattedString
    }
    
}
