//
//  GroupView.swift
//  Office Group
//
//  Created by Charlton Shih on 8/12/24.
//

import SwiftUI
import SwiftData

struct GroupView: View {
    @State private var isPresented = false
    @Environment(\.modelContext) private var context
    @Query(sort: \GroupInfo.name) var people: [GroupInfo]
    @State private var toEdit: GroupInfo?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { person in
                    GroupInfoCell(people: person)
                        .onTapGesture {
                            toEdit = person
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(people[index])
                    }
                    try? context.save()  // Save to persistent storage
                }
            }
            .navigationTitle("Group Members")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if !people.isEmpty {
                    Button(action: {
                        isPresented = true
                    }) {
                        Label("Add Member", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresented) {AddPersonView()}
            .sheet(item:$toEdit) { person in
                updateGroupInfo(information: person)
            }
            .overlay {
                if people.isEmpty {
                    VStack {
                        Label("No members", systemImage: "person.3")
                        Button("Add member") {
                            isPresented = true
                        }
                        .padding(.top, 20)
                    }
                    .offset(y: -60)
                }
            }
        }
    }
}

struct GroupInfoCell: View {
    let people: GroupInfo

    var body: some View {
        HStack {
            Text(people.name)
            Spacer()
            Text(people.email)
        }
    }
}

#Preview {
    GroupView()
}

struct AddPersonView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Member Details")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Add Group Member")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if isValidEmail(email) {
                            let newPerson = GroupInfo(name: name, email: email)
                            context.insert(newPerson)
                            try? context.save()
                            dismiss()
                        } else {
                            alertMessage = "Please enter a valid email address."
                            showAlert = true
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Email"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Regular expression to validate email address
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

struct updateGroupInfo: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var information: GroupInfo
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Member Details")) {
                    TextField("Name", text: $information.name)
                    TextField("Email", text: $information.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Update Information")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
}
