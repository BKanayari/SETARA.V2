//
//  WelcomeScreenThreeView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/04/23.
//

import SwiftUI

struct WelcomeScreenThreeView: View {
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                VStack {
                    Image("welcomescreentiga")
                        .resizable()
                        .scaledToFit()
                    Text("Help you to split bill with your friend")
                        .fontWeight(.medium)
                    
                    HStack {
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 50, height: 10)
                        Capsule()
                            .fill(Color.orange)
                            .frame(width: 100, height: 10)
                        
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 50, height: 10)
                    }
                    .padding(.bottom)
                    .padding(.bottom)
                    Text("Sometimes Split bill is challenging if you don't know how to do it fairly and lorem lorem lorem lorem lorem lorem lorem")
                        .frame(alignment:Alignment.trailing)
                        .padding(.horizontal)
                        .padding()
                    Button {
                    }
                label: {
                    Text("Next")
                        .fontWeight(.bold)
                        .font(.system(.title2, design: .rounded))
                }
                .frame(width: 200)
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(20)
                .shadow(radius: 5)
                    Spacer()
                        .frame(height: 200)
                }
            }
        }
    }
    
}

struct WelcomeScreenThreeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenThreeView()
    }
}
