//
//  ListView.swift
//  Snacktacular
//
//  Created by Aimee Hong on 11/4/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            List {
                Text("List items will go here")
            }
            .listStyle(.plain)
            .navigationTitle("Snack Spots:")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: Add record code here
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

#Preview {
    ListView()
}