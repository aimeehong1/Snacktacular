//
//  SpotDetailView.swift
//  Snacktacular
//
//  Created by Aimee Hong on 11/10/24.
//

import SwiftUI

struct SpotDetailView: View {
    @State var spot: Spot // pass in value from ListView
    @State private var photoSheetIsPresented = false
    @State private var showingAlert = false // Alert user
    private let alertMessage = "Cannot add a photo until you save the spot."
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("name", text: $spot.name)
                    .font(.title)
                    .autocorrectionDisabled()
                
                TextField("address", text: $spot.address)
                    .font(.title2)
                    .autocorrectionDisabled()
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            Button { // Photo Button
                if spot.id == nil { // Ask if you want to save
                    showingAlert.toggle()
                } else { // Go right to PhotoView
                    photoSheetIsPresented.toggle()
                }
            } label: {
                Image(systemName: "camera.fill")
                Text("Photo")
            }
            .bold()
            .buttonStyle(.borderedProminent)
            .tint(.snack)

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
                    saveSpot()
                    dismiss()
                }
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Save") {
                // we want to return spot.id after saving a new Spot. Right now it's nil
                Task {
                    guard let id = await SpotViewModel.saveSpot(spot: spot) else {
                        print("😡 ERROR: Saving spot in alert returned nil")
                        return
                    }
                    spot.id = id
                    print("spot.id: \(id)")
                    photoSheetIsPresented.toggle() // now open sheet & move to PhotoView
                }
            }
        }
        .fullScreenCover(isPresented: $photoSheetIsPresented) {
            PhotoView(spot: spot)
        }
    }
    
    func saveSpot() {
        Task {
            guard let id = await SpotViewModel.saveSpot(spot: spot) else {
                print("😡 ERROR: Saving spot from Save button")
                return
            }
            print("spot.id: \(id)")
            print("😎 Nice Spot save!")
        }
    }
}

#Preview {
    NavigationView {
        SpotDetailView(spot: Spot())
    }
}
