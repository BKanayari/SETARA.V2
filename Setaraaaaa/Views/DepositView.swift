//
//  DepositView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 18/04/23.
//

import SwiftUI

struct DepositView: View {
    @State var listNameTable: [Participant]
    @State private var depositNumber: String = ""
    @State private var selectedPerson = 0
    @Binding var isPresented: Bool
    @State private var showAlert = false
    var index: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            TextField("Enter the number here", text: $depositNumber)
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

            // logic deposit here
            
            var depositPerson = ParticipantData.shared.getParticipant(
                name: listNameTable[selectedPerson].name) ??
            Participant(name: "", isParticipated: false,
                     food: [ParticipantItem(itemName: "", itemPrice: 0)], total: 0)
            var tmpTotal = 0
            var calculateDepositWithTotal = 0
            Button(action: {
                tmpTotal = depositPerson.total
                calculateDepositWithTotal = tmpTotal - (Int(depositNumber) ?? 0)
                depositPerson.total = calculateDepositWithTotal
                ParticipantData.shared.addParcticipant(participantName: depositPerson)
                isPresented = false
                dismiss()
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
        }
    }
}

struct DepositView_Previews: PreviewProvider {
    static var previews: some View {
        DepositView(listNameTable: [Participant(name: "Me", isParticipated: true, food: [], total: 100)], isPresented: .constant(true), index: 0)
    }
}
