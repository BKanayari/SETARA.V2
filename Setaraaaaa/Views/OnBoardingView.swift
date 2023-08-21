//
//  ViewDuaView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 31/03/23.
//

import SwiftUI

struct OnBoardingView: View {
    /// track the current page of onboarding
    @State private var currentPage: Int = 0
    /// keep track of onboarding completion
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        Group {
            if isOnboarding ?? true {
                VStack {
                    /// showing image carousel  on the view
                    ImageCarouselView(currentPage: $currentPage)

                    /// to show page indicator in the view
                    VStack(spacing: 10) {
                        Text("Help you to split bill with your friend")
                            .fontWeight(.medium)
                        PageIndicatorView(currentPage: $currentPage)
                        Text("Sometimes Split bill is challenging if you don't know how to do it. Here we give you some how to do it fairly")
                            .frame(alignment: .trailing)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                            .padding()

                        /// button to navigate through onboarding pages
                        TabView(selection: $currentPage) {
                            ForEach(0..<3) { pageIndex in
                                if pageIndex != 2 {
                                    Button {
                                        currentPage += 1
                                    } label: {
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .font(.system(.title2, design: .rounded))
                                            .frame(width: 200)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(Color("BasicYellow"))
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                            .padding(.top, 70)
                                    }
                                } else {
                                    /// on last page, button will change to the modifier that has been set below
                                    Button(action: {
                                        isOnboarding = false
                                    }) {
                                        Text("Get Started")
                                            .fontWeight(.bold)
                                            .font(.system(.title2, design: .rounded))
                                            .frame(width: 200)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(Color("BasicYellow"))
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                            .padding(.top, 70)
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                /// show participant list view if onboarding is completed
                ParticipantListView()
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

/// image carousel view for onboarding images
struct ImageCarouselView: View {
    @Binding var currentPage: Int

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<3) { i in
                Image("welcomescreen\(i + 1)")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 353, height: 353)
            }
        }
    }
}

/// page indicator dots for onboarding pages
struct PageIndicatorView: View {
    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { i in
                Color("BasicYellow")
                    .opacity(i == currentPage ? 1 : 0.5)
                    .frame(width: i == currentPage ? 80 : 47, height: 8)
                    .cornerRadius(10)
            }
            .padding(.trailing, 2)
        }
    }
}
