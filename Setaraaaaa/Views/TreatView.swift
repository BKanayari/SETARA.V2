//
//  TreatView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 13/04/23.
//

import SwiftUI

struct TreatView: View {
    @State var listNameTable: [Participant]
    @State private var treatNumber: String = ""
    @State private var selectedPerson = 0
    @Binding var isPresented: Bool
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    var index: Int

    var body: some View {
        VStack {
            TextField("Enter the number here", text: $treatNumber)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.leading, 10)
                .keyboardType(.numberPad)

            Picker("Choose the person", selection: $selectedPerson, content: {
                ForEach(0..<listNameTable.count, id: \.self) { index in
                    if listNameTable[index].isParticipated {
                        Text("\(listNameTable[index].name)")
                    }
                }
            })
            .pickerStyle(WheelPickerStyle())

            // logic calculate treat

            var treatPerson = ParticipantData.shared.getParticipant(name: listNameTable[selectedPerson].name) ?? Participant(name: "", isParticipated: false, food: [ParticipantItem(itemName: "", itemPrice: 0)], total: 0)

            let intTreatNumber = Int(treatNumber) ?? 0

            Button(action: {
                if treatPerson.total < intTreatNumber {
                    //                    treatPerson.total = intTreatNumber

                    print(treatPerson.total)

                    var sumTmpTotal = 0 /// tmp = temporary

                    for i in 0..<listNameTable.count {
                        let participantss = ParticipantData.shared.getParticipant(name: listNameTable[i].name)

                        sumTmpTotal += participantss?.total ?? 0
                    }

                    let calculateTreatment = (sumTmpTotal - intTreatNumber) / (listNameTable.count - 1)

//                    var tmpTotal = 0

                    for i in 0..<listNameTable.count {
                        if i != selectedPerson {
                            var participantss = ParticipantData.shared.getParticipant(name: listNameTable[i].name)

                            participantss?.total = calculateTreatment

                            ParticipantData.shared.addParcticipant(participantName: participantss!)
                        }
                    }

                    treatPerson.total = intTreatNumber
                    ParticipantData.shared.addParcticipant(participantName: treatPerson)

                    dismiss()
                } else {
                    showAlert.toggle()
                }

                isPresented = false
            }) {
                Text("Done")
                    .fontWeight(.bold)
                    .font(.system(.title2, design: .rounded))
                    .frame(width: 150, height: 50, alignment: .center)
                    .background(Color("BasicYellow"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your money is not enough"), message: Text("Put the right number"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct TreatView_Previews: PreviewProvider {
    static var previews: some View {
        TreatView(listNameTable: [Participant(name: "Me", isParticipated: true, food: [], total: 100)], isPresented: .constant(true), index: 0)
    }
}
