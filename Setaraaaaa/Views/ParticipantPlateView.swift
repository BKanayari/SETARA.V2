//
//  TablePlateView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/04/23.
//

import SwiftUI

struct ParticipantPlateView: View {
    @State var participantPlate: [Participant]
    @State private var isNavigated = false
    @State private var showingTreatSheet = false
    @State private var showingDepositSheet = false
    @State private var isPresented = false

    var body: some View {
        VStack {
            /// background
            HStack {
                Spacer()
                Image("Triangle")
            }
            HStack(spacing: 50) {
                VStack {
                    /// button to triger treat sheet
                    Button(
                        action: {
                            showingTreatSheet.toggle()
                            isPresented = true
                        }, label: {
                            Image("Cake")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    ).sheet(isPresented: $showingTreatSheet) {
                        TreatView(listNameTable: participantPlate, isPresented: $isPresented, index: 0)
                                }
                    Text("Treat")
                        .font(.system(size: 20, weight: .medium))
                        .frame(alignment: .trailing)
                }
                VStack {
                    /// button to triger deposit sheet
                    Button(action: {
                        isPresented = true
                        showingDepositSheet.toggle()
                    }, label: {
                        Image("BankPiggy")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    })
                    .sheet(isPresented: $showingDepositSheet) {
                        DepositView(listNameTable: participantPlate, isPresented: $isPresented, index: 0)
                    }
                    Text("Deposit")
                        .font(.system(size: 20, weight: .medium))
                        .frame(alignment: .trailing)
                }
            }
            Spacer()
            /// participant plates will appear here sideways and can be scrolled horizontally
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    /// show  participant plate
                    ForEach(0..<participantPlate.count, id: \.self) { i in
                        if participantPlate[i].isParticipated {
                            /// stored retrieve data from ParticipantData to let totalExpenses
                            let totalExpenses = ParticipantData.shared.getParticipant(name: participantPlate[i].name)
                            ZStack(alignment: .bottom) {
                                VStack(alignment: .center) {
                                    /// navigation button to DetailParticipantPlateView
                                    NavigationLink(destination: DetailParticipantPlateView(participant: participantPlate[i], listNameTable: $participantPlate, index: i)) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .cornerRadius(100)
                                                .frame(width: 160, height: 160)
                                                .shadow(radius: 8)
                                            Image("Piring")
                                                .resizable()
                                                .frame(width: 150, height: 150)
                                                .scaledToFit()
                                                .cornerRadius(20)
                                        }
                                    }
                                    Text(participantPlate[i].name)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    Text("Rp \(totalExpenses?.total ?? 0) ")
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 25)
                            }
                        }
                    }
                }.padding(.bottom, 40)
            }
            /// navigation button to SplitBillResultView
            NavigationLink(destination: SplitBillResultView(listNameTable: participantPlate), isActive: $isNavigated) {
                Button(
                    action: {
                        isNavigated = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 230, height: 60)
                                .shadow(radius: 5)
                                .foregroundColor(Color("BasicYellow"))
                            Text("Result")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                )
            }
            /// background
            HStack {
                Image("Oval")
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Plates")
                    .font(.title2.bold())
                    .accessibilityAddTraits(.isHeader)
            }
        }
    }
}

struct ParticipantPlateView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantPlateView(participantPlate: [Participant(name: "Me", isParticipated: false, food: [ParticipantItem(itemName: "Tarempa", itemPrice: 10_000)], total: 0)])
    }
}
