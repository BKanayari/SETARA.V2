//
//  HomeView.swift
//  Setaraaaaa
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/04/23.
//

import SwiftUI

struct ParticipantListView: View {
    @State private var isInvolveParticipant: [Bool] = [false, false] /// participant that join the split bill
    @State private var showingAlert = false
    @State private var showingAlertParticipant = false /// showing alert if participant less than 2 people
    @State private var isNavigated = false
    @State private var isNextButtonActive = true
    @State var involvedParticipant: Int = 0 /// amout of participant that join the split bill
    @State var participantName: [String] = ["Me"] /// set one default participant name to array
    @State var participantList: [Participant] = [
        Participant(name: "Me",
                    isParticipated: false,
                    food: [],
                    total: 0),
    ] /// set one default participant to Participant array

    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    /// list of participant name
                    List {
                        ForEach(0..<participantName.count, id: \.self) { index in
                            HStack {
                                /// button to change isInvolveParticipant value to true if the participant want to join the split bill
                                Button(action: {
                                    /// changing isInvolveParticipant boolean value to true or false
                                    isInvolveParticipant[index].toggle()

                                    /// change participantList.isParticipated to true or false
                                    participantList[index].isParticipated.toggle()

                                    /// checks whether the participant has entered the array or not
                                    print("State : \(isInvolveParticipant)")

                                    /// stored retrieve data from ParticipantData to let isNamePresent
                                    let isNamePresent = ParticipantData.shared.getParticipant(name: participantName[index])

                                    /// checks whether the participant name already exists in the array or not before
                                    if isNamePresent == nil {
                                        ParticipantData.shared.addParcticipant(participantName: Participant(name: "me", isParticipated: false, food: [], total: 0))
                                        print("Successful add \(participantName[index])")
                                    } else {
                                        print("name already exists")
                                    }

                                    /// checks if the value of isInvolveParticipant is true then it will add 1 value involvedParticipant
                                    if isInvolveParticipant[index] == true {
                                        involvedParticipant += 1
                                        print("involvedParticipant+1")
                                    } else {
                                        /// will reduce 1 value if the value of isInvolveParticipant  is false
                                        involvedParticipant -= 1
                                        print("involvedParticipant-1")
                                    }

                                    /// checking condition if participant less than 2 user can't move to next view
                                    if involvedParticipant < 2 {
                                        isNextButtonActive = true
                                    } else {
                                        isNextButtonActive = false
                                    }
                                }) {
                                    HStack( spacing: 10) {
                                        /// contents list
                                        Text("\(participantName[index])")
                                            .lineLimit(1)
                                            .frame(width: 200, alignment: .leading)
                                        Rectangle()
                                            .fill(isInvolveParticipant[index] ? Color("BasicYellow") : Color.gray)
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .cornerRadius(5)
                                            .padding(.leading, 120)
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                                        Button {
                                            participantName.remove(at: index)
                                        } label: {
                                            Image(systemName: "trash")
                                        }.tint(.red)
                                    })
                                }
                                .foregroundColor(Color.black)
                            }
                        }
                    }
                    NavigationLink(destination: ParticipantPlateView(participantPlate: participantList), isActive: $isNavigated) {
                        Button {
                            /// app will show alert if amount of involvedParticipant less than 2
                            if involvedParticipant < 2 {
                                showingAlertParticipant = true
                            } else {
                                isNavigated = true
                            }
                        }
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 230, height: 60)
                                .shadow(radius: 5)
                                .foregroundColor(Color("BasicYellow"))
                            Text("Next")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                    }
                }
                .navigationTitle("Participants")
                .background(Image("BackGround"))
                .listStyle(.plain)
                .alert(isPresented: $showingAlertParticipant) {
                    Alert(title: Text("Warning"), message: Text("Please add at least 2 participants."), dismissButton: .default(Text("OK")))
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        /// button to add participant
                        Button(
                            /// trigger custom alert
                            action: {
                                alertTF(title: "Add Participants Name", message: "Enter the names of the person in your group", hintText: "Name", primaryTitle: "Cancel", secondaryTitle: "Add") { text in
                                    if text.isEmpty {
                                        showingAlert.toggle()
                                    } else {
                                        participantName.append(text)
                                        isInvolveParticipant.append(false)
                                        participantList.append(Participant(name: text, isParticipated: false, food: [], total: 0))
                                    }
                                }
                            secondaryAction: {
                                print("Cancelled")
                            }
                            }, label: {
                                Image(systemName: "plus")
                            }
                        ).alert(isPresented: $showingAlert) {
                            Alert(title: Text("WARNING").foregroundColor(.red), message: Text("The name is empty"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.large)
            .accentColor(Color("BasicYellow"))
        }
    }
}

struct ParticipantListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantListView()
    }
}

/// Custom Alert View
extension View {
    func alertTF(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String) -> Void, secondaryAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }

        alert.addAction(.init(title: primaryTitle, style: .cancel, handler: { _ in secondaryAction() }))

        alert.addAction(.init(title: secondaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
            } else {
                primaryAction("")
            }
        }))

        rootController().present(alert, animated: true, completion: nil)
    }

    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return.init()
        }

        return root
    }
}


