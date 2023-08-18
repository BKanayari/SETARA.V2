//
//  UserDefaults.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 11/04/23.
//

import Foundation


struct SharedPreferences: Codable {
    
    static let shared = SharedPreferences()
    
    
    func addParcticipant(participantName: ListName) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(participantName)
            
            UserDefaults.standard.set(data, forKey: participantName.name)
        } catch {
            print("Unable to Encode Participant (\(error))")
        }

    }
    
    func getParitcipant(name: String) -> ListName? {
        if let data = UserDefaults.standard.data(forKey: name) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let participant = try decoder.decode(ListName.self, from: data)
                return participant
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    func addFood(name: String, food: FoodList) {
        if let participant = getParitcipant(name: name) {
            var newParticipant = participant
            newParticipant.food.append(food)
            addParcticipant(participantName: newParticipant)
        }else{
            print("Ngk masokk")
        }
    }
    
    func deleteFood(name: String, index: Int) {
        
        if let participant = getParitcipant(name: name) {
            var newparticipant = participant
            newparticipant.total = newparticipant.total  - newparticipant.food[index].itemPrice
            newparticipant.food.remove(at: index)
            addParcticipant(participantName: newparticipant)
            
        }
        
    }
    
    func deleteAllTransaction(name: String, index: Int) {
        
        if let participant = getParitcipant(name: name) {
            var newparticipant = participant
            newparticipant.total = 0
            newparticipant.food.removeAll()
            addParcticipant(participantName: newparticipant)
            
        }
        
    }
}
