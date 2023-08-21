//
//  File.swift
//  Setaraaaaa
//
//  Created by bernardus kanayari on 18/08/23.
//

import Foundation

struct ListName: Codable {
    var name: String
    var isChecked: Bool
    var food: [FoodList]
    var total: Int
}
