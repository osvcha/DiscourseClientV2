//
//  String+Extensions.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 21/03/2021.
//


let htmlReplaceString: String = "<[^>]+>"


extension String {
    
    func stripHTML() -> String {
        
        return self.replacingOccurrences(of: htmlReplaceString, with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
