//
//  SpotViewModel.swift
//  Snacktacular
//
//  Created by Aimee Hong on 11/10/24.
//

import Foundation
import FirebaseFirestore

@Observable
class SpotViewModel {
    
    func saveSpot(spot: Spot) -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id { // if true the spot exists
            do {
                try db.collection("spots").document(id).setData(from: spot)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else { // we need to add a new spot & create a new id / document name
            do {
                try db.collection("spots").addDocument(from: spot)
                print("🐣 Data added successfully!")
                return true
            } catch {
                print("😡 Could not create data in 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
}
