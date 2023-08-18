//
//  TablePlateView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/04/23.
//

import SwiftUI


struct TablePlateView: View {
    
    @State var listNameTable: [ListName]
    
    @State private var navigated = false
    @State private var showingSheet = false
    @State private var showingSheetDeposit = false
    @State private var isPresented = false
    
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Image("Triangle")
            }
            
            HStack(spacing: 50) {
                
                VStack() {
                    
                    Button(
                        action: {
                            
                            showingSheet.toggle()
                            
                            isPresented = true
                            
                            
                        }, label: {
                            Image("Cake")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        
                    ) .sheet(isPresented: $showingSheet) {
                        TreatView(listNameTable: listNameTable, isPresented: $isPresented, index: 0)
                        
                        
                    }
                    Text("Treat")
                        .font(.system(size: 20, weight: .medium))
                        .frame(alignment: .trailing)
                }
                
                VStack {
                    
                    Button(action: {
                        
                        isPresented = true
                        
                        showingSheetDeposit.toggle()
                        
                    }, label: {
                        Image("BankPiggy")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    })
                    .sheet(isPresented: $showingSheetDeposit) {
                        DepositView(listNameTable: listNameTable, isPresented: $isPresented ,index: 0)
                    }
                    
                    Text("Deposit")
                        .font(.system(size: 20, weight: .medium))
                        .frame(alignment: .trailing)
                }
            }
            
            Spacer()
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 25) {
                    
                    ForEach(0..<listNameTable.count) { i in
                        if listNameTable[i].isChecked {
                            
                            let totalSum = SharedPreferences.shared.getParitcipant(name: listNameTable[i].name)
                            
                            ZStack(alignment: .bottom) {
                                
//                                Color(.gray)
//                                    .frame(height: 250)
//                                    .cornerRadius(10)
//                                    .opacity(0.6)
                                
                               
                                VStack(alignment: .center) {
                                    NavigationLink (destination: ItemView(participant: listNameTable[i], listNameTable: $listNameTable, index: i)) {
                                        
                                        
                                        ZStack{
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
                                    
                                    Text(listNameTable[i].name)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    
                                    Text("Rp \(totalSum?.total ?? 0) ")
                                    
                                    
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 25)
                                
                            }
                        }
                        
                    }
                    
                }.padding(.bottom, 40)
            }
            
            NavigationLink (destination: SpendingView(listNameTable: listNameTable), isActive: $navigated) {
                
                Button(
                    action: {
                        self.navigated = true
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 230,height: 60)
                                .shadow(radius: 5)
                                .foregroundColor(CustomColor.myColor)
                            Text("Result")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                )
            }
            HStack{
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


struct TablePlateView_Previews: PreviewProvider {
    static var previews: some View {
        TablePlateView(listNameTable: [ListName(name: "Me", isChecked: false, food: [FoodList(itemName: "Tarempa", itemPrice: 10000)], total: 0)])
    }
}


