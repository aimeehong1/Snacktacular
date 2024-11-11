//
//  SpotDetailView.swift
//  Snacktacular
//
//  Created by Aimee Hong on 11/10/24.
//

import SwiftUI

struct SpotDetailView: View {
    @State var spot: Spot // pass in value from ListView
    @State var spotVM = SpotViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("name", text: $spot.name)
                    .font(.title)
                
                TextField("address", text: $spot.address)
                    .font(.title2)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let success = spotVM.saveSpot(spot: spot)
                    if success {
                        dismiss()
                    } else {
                        print("😡 Dang! Error saving spot!")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationView {
        SpotDetailView(spot: Spot())
    }
}