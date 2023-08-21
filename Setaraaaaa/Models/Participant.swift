//
//  File.swift
//  Setaraaaaa
//
//  Created by bernardus kanayari on 18/08/23.
//

import Foundation

struct Participant: Codable {
    var name: String
    var isParticipated: Bool
    var food: [ParticipantItem]
    var total: Int
}
