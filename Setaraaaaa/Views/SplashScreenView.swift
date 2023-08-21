//
//  SplashScreenView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 11/04/23.
//

import SwiftUI

/// Splash Screen
struct SplashScreenView: View {
    @AppStorage("isOnboarding") var isOnboarding = true
    /// to check if the user has opened the app before or not
    @State var alreadyOpenApp: Bool = false

    var body: some View {
        ZStack {
            /// if the user already open the app, it will directly move to onBoardingView
            if alreadyOpenApp {
                OnBoardingView()
            } else {
                Image("splashScreenTiga")
                    .resizable()
                    .frame(width: 300, height: 300)
            }
        }
        /// asynchornous change  value of alreadyOpenApp to  "true" when user first open the app
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    alreadyOpenApp = true
                }
            }
        }
    }

    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
