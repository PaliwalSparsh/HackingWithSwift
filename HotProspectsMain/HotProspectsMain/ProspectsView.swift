//
//  ProspectsView.swift
//  HotProspectsMain
//
//  Created by Sparsh Paliwal on 12/7/23.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showSortOptions = false
    @State private var sortByName = false
    
    var filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if(filter == .none) {
                            Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark":  "person.crop.circle.badge.xmark")
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)

                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button {
                        showSortOptions = true
                    } label: {
                        Label("Sort", systemImage: "filter")
                    }
                }

            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Sparsh Paliwal\npaul@hackingwithswift.com", completion: handleScan)
            }
            .confirmationDialog("Sort Options", isPresented: $showSortOptions) {
                Button("By name") {
                    sortByName = true
                }
                Button("By adding date") {
                    sortByName = false
                }
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            /// let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Oops!")
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
            case .success(let result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 2 else { return }
                let person = Prospect()
                person.name = details[0]
                person.email = details[1]
                prospects.add(prospect: person)
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    var title: String {
        switch filter {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted"
            case .uncontacted:
                return "Uncontacted"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
            case .none:
            return sortByName ? prospects.people.sorted() : prospects.people
            case .contacted:
            
            return sortByName ? prospects.people.filter { $0.isContacted }.sorted() : prospects.people.filter { $0.isContacted }
            case .uncontacted:
            return sortByName ? prospects.people.filter { !$0.isContacted }.sorted() : prospects.people.filter { !$0.isContacted }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
