//
//  SpendingView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/04/23.
//

import SwiftUI

struct SplitBillResultView: View {
    @State var listNameTable: [Participant]
    @State var returnHome = false
    @State private var showingAlert = false

    var body: some View {
        if returnHome {
            ParticipantListView()
        } else {
            VStack {
                VStack(alignment: .leading) {
                    Text("Expenses")
                        .padding(.top, 20.0)
                        .padding(.leading, 15.0)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    List {
                        ForEach(0..<listNameTable.count, id: \.self) { i in
                            if listNameTable[i].isParticipated {
                                let participantss = ParticipantData.shared.getParticipant(name: listNameTable[i].name)
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .padding(.trailing, 10)
                                    VStack {
                                        Text("\(listNameTable[i].name)")
                                            .lineLimit(2)
                                            .frame(alignment: .leading)
                                    }
                                    Spacer()
                                    Text("Rp \(participantss!.total)")
                                        .frame(width: 100, height: 100, alignment: .leading)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                    .frame(width: 360, height: 470)
                    .background(Color.gray)
                    .cornerRadius(25)
                    .padding(.bottom, 80)

                    Button {
                        showingAlert = true
                    } label: {
                        Text("Finish")
                            .fontWeight(.bold)
                            .font(.system(.subheadline, design: .rounded))
                            .frame(width: 200)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("BasicYellow"))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .padding(.leading, 70)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Are you sure ?"),
                            message: Text("After this the transaction will be deleted"),
                            primaryButton: .destructive(Text("OK")) {
                                for i in (0..<listNameTable.count ) {
                                    ParticipantData.shared.deleteAllTransaction(name: listNameTable[i].name, index: i)
                                }
                                returnHome = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
        }
    }
}
