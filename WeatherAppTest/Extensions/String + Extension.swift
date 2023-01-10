//
//  String + Extension.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 07.01.2023.
//

import Foundation

extension String {
    
    func capitalizedFirst() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
