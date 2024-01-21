//
//  ContentView.swift
//  touchIDSwiftUI
//
//  Created by asmaa gamal  on 21/01/2024.
//
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Button("Authenticate with Touch ID") {
                    authenticate()
                }
            }
        }
        .padding()
    }

    func authenticate() {
        let context = LAContext()

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to unlock") { success, error in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        // Handle authentication failure
                        print("Authentication failed: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            // Biometric authentication not available
            print("Biometric authentication not available on this device")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
