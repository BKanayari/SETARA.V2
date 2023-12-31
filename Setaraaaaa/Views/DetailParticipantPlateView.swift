//
//  ItemView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/04/23.
//

import SwiftUI

struct DetailParticipantPlateView: View {
    @State var checkState = false
    @State var participant: Participant
    @State var itemNames: [String] = []
    @State var priceItems: [String] = []
    @State var counter: Int = 0
    @State var discount: String = ""
    @State var reload = false
    @State var totalPerson = 0
    @State private var isToggle: [Bool] = [false, false, false]
    @State private var nameItem: String = ""
    @State private var basePrice: String = ""
    @State private var showingAlert = false
    @State private var feeIDR: String = ""
    @State private var taxPercent: String = ""
    @State private var taxIDR: String = ""
    @FocusState var isFocused: Bool
    @Binding var listNameTable: [Participant]
    var index: Int
    
    var body: some View {
        VStack {
            VStack {
                List {
                    if true {
                        if let participantss = ParticipantData.shared.getParticipant(name: participant.name) {
                            ForEach(0..<participantss.food.count, id: \.self) {i in
                                HStack {
                                    Text("\(participantss.food[i].itemName)")
                                        .fontWeight(.regular)
                                        .font(.system(size: 16))
                                    Spacer()
                                    Text("Rp \(participantss.food[i].itemPrice)")
                                        .fontWeight(.light)
                                        .font(.system(size: 16))
                                        .frame(width: 100, alignment: .leading)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                                    Button {
                                        ParticipantData.shared.deleteFood(name: participantss.name, index: i)
                                        isToggle[0] = true
                                        isToggle[0] = false
                                        listNameTable[index] = Participant(name: participant.name, isParticipated: participant.isParticipated, food: participant.food, total: participant.total)
                                    } label: {
                                        Image(systemName: "trash")
                                    } .tint(.red)
                                })
                            }
                        }
                    }
                }
                VStack(alignment: .center, spacing: 20) {
                    Text("Add Item")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    HStack {
                        Text("Name")
                            .padding(.leading, 15)
                        
                        TextField("Item", text: $nameItem)
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity)
                            .lineLimit(2)
                            .focused($isFocused)
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, -10)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 20), alignment: .top)
                    .foregroundColor(Color("SoftGray"))
                    .padding(.bottom, 25)
                    HStack {
                        Text("Base Price")
                            .padding(.leading, 15)
                        TextField("Enter the number", text: $basePrice)
                            .padding(.leading, 5)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                    }
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    .padding(.vertical, -20)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 20), alignment: .top)
                    .foregroundColor(Color("SoftGray"))
                    
                    // View untuk discount, tax dan fee
                    
                    HStack {
                        Text("Disc")
                            .padding(.leading, 10)
                        Toggle(isOn: $isToggle[0]) {
                        }
                        .padding(.trailing, 175)
                        HStack {
                            Text("\(discount) %")
                                .foregroundColor(.gray)
                            Button("%") {
                                alertTF(title: "%", message: "", hintText: "Enter the percent of number", primaryTitle: "Cancel", secondaryTitle: "OK") { text in
                                    discount = text
                                    print("discount", discount)
                                } secondaryAction: {
                                    print("Cancelled")
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                            .frame(width: 70, height: 30, alignment: .center)
                            .background(Color("BasicYellow"))
                            .disabled(!isToggle[0])
                        }
                        .padding(.trailing, 10)
                        .cornerRadius(3)
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, -15)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 20), alignment: .top)
                    .foregroundColor(Color("SoftGray"))
                    .padding(.top, 60)
                    .padding(.bottom, 30)
                    HStack {
                        Text("Tax")
                        Toggle(isOn: $isToggle[1]) {
                        }
                        .padding(.trailing, 105)
                        HStack {
                            Text("\(taxPercent)")
                                .foregroundColor(.gray)
                            Button("%") {
                                alertTF(title: "%", message: "", hintText: "Enter the percent of number", primaryTitle: "Cancel", secondaryTitle: "OK") { text in
                                    taxPercent = text
                                    print("discount", taxPercent)
                                } secondaryAction: {
                                    print("Cancelled")
                                }
                            }
                            .frame(width: 70, height: 30)
                            .foregroundColor(.white)
                            .background(Color("BasicYellow"))
                            .padding(.leading, 70)
                            .padding(.trailing, 10)
                            .disabled(!isToggle[1])
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.vertical, -15)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 20), alignment: .top)
                    .foregroundColor(Color("SoftGray"))
                    .padding(.bottom, 30)
                    HStack {
                        Text("Fee")
                            .padding(.leading, 10)
                        Toggle(isOn: $isToggle[2]) {
                        }
                        .padding(.trailing, 175)
                        Text("\(feeIDR)")
                            .foregroundColor(.gray)
                        Button("IDR") {
                            alertTF(title: "IDR", message: "", hintText: "Enter the number", primaryTitle: "Cancel", secondaryTitle: "OK") { text in
                                feeIDR = text
                                print("discount", feeIDR)
                            } secondaryAction: {
                                print("Cancelled")
                            }
                        }
                        .frame(width: 70, height: 30)
                        .foregroundColor(.white)
                        .background(Color("BasicYellow"))
                        .padding(.trailing, 10)
                        .disabled(!isToggle[2])
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, -15)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 20), alignment: .top)
                    .foregroundColor(Color("SoftGray"))
                    .padding(.bottom, 60)
                    ZStack {
                        Button {
                            if nameItem.isEmpty || basePrice.isEmpty {
                                showingAlert.toggle()
                            } else {
                                if isToggle[0] {
                                    print("discount integer", Int(discount) ?? 0)
                                    let discountInt = Int(discount) ?? 0
                                    let basePriceInt = Int(basePrice) ?? 0
                                    let totalDiscount = (basePriceInt * (100 - discountInt) ) / 100
                                    ParticipantData.shared.addFood(name: participant.name,
                                                                   food: ParticipantItem(itemName: nameItem,
                                                                                  itemPrice: totalDiscount))
                                } else if isToggle[1] {
                                    let taxInt = Int(taxPercent) ?? 0
                                    let basePriceInt = Int(basePrice) ?? 0
                                    let totalDiscount = (basePriceInt * (100 + taxInt)) / 100
                                    ParticipantData.shared.addFood(
                                        name: participant.name,
                                        food: ParticipantItem(itemName: nameItem,
                                                       itemPrice: totalDiscount))
                                } else if isToggle[2] {
                                    let taxInt = Int(feeIDR) ?? 0
                                    let basePriceInt = Int(basePrice) ?? 0
                                    let totalDiscount = basePriceInt + taxInt
                                    ParticipantData.shared.addFood(name: participant.name, food: ParticipantItem(itemName: nameItem, itemPrice: totalDiscount))
                                } else {
                                    ParticipantData.shared.addFood(name: participant.name, food: ParticipantItem(itemName: nameItem, itemPrice: Int(basePrice) ?? 0))
                                }
                                var tmpTotal = 0
                                var tmpParticipant = ParticipantData.shared.getParticipant(name: participant.name) ?? Participant(name: "", isParticipated: false, food: [ParticipantItem(itemName: "", itemPrice: 0)], total: 0)
                                for i in 0..<(tmpParticipant.food.count ) {
                                    print("i: ", i)
                                    tmpTotal += tmpParticipant.food[i].itemPrice
                                    tmpParticipant.total = tmpTotal
                                    print("Hasilnya: ", tmpParticipant)
                                    let countt = ParticipantData.shared.getParticipant(name: participant.name)
                                    print(countt?.total ?? 0)
                                    ParticipantData.shared.addParcticipant(participantName: tmpParticipant)
                                }
                                isToggle[0] = false
                                isToggle[1] = false
                                isToggle[2] = false
                                basePrice = ""
                                nameItem = ""
                                print("total: ", tmpParticipant.total)
                                isFocused = false
                                listNameTable[index] = Participant(name: participant.name,
                                                                isParticipated: participant.isParticipated,
                                                                food: participant.food,
                                                                total: participant.total)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 200, height: 60, alignment: .center)
                                    .shadow(radius: 5)
                                    .foregroundColor(Color("BasicYellow"))
                                Text("Add")
                                    .font(.system(.title2, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("WARNING").foregroundColor(.red), message: Text("The name or base price is wrong"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .padding(.bottom, 10)
                .padding(.top, 30)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(participant.name)")
    }
}

struct DetailParticipantPlateView_Previews: PreviewProvider {
    static var previews: some View {
        DetailParticipantPlateView( participant: Participant(name: "Hengky", isParticipated: false, food: [ParticipantItem(itemName: "", itemPrice: 0)], total: 0), listNameTable: .constant([]), index: 0 )
    }
}
