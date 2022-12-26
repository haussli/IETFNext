//
//  LocationDetailView.swift
//  IETFNext
//
//  Created by Tom Pusateri on 12/25/22.
//

import SwiftUI

struct LocationDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.verticalSizeClass) var sizeClass

    @SectionedFetchRequest<String, Session> var fetchRequest: SectionedFetchResults<String, Session>
    @Binding var selectedMeeting: Meeting?
    @Binding var selectedLocation: Location?

    init(selectedMeeting: Binding<Meeting?>, selectedLocation: Binding<Location?>) {
        let number = selectedMeeting.wrappedValue?.number ?? "0"
        let location_name = selectedLocation.wrappedValue?.name ?? "0"

        _fetchRequest = SectionedFetchRequest<String, Session> (
            sectionIdentifier: \.day!,
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Session.start, ascending: true),
                NSSortDescriptor(keyPath: \Session.end, ascending: false),
            ],
            predicate: NSPredicate(format: "(meeting.number = %@) AND (location.name = %@)", number, location_name),
            animation: .default
        )

        self._selectedMeeting = selectedMeeting
        self._selectedLocation = selectedLocation
    }

    var body: some View {
        if let location = selectedLocation {
            VStack() {
                Text("\(location.level_name!)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                AsyncImage(url: location.map, transaction: Transaction(animation: .spring())) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            if colorScheme == .light {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .transition(.scale)
                            } else if colorScheme == .dark {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .transition(.scale)
                                    .colorInvert()
                            }
                        case .failure(_):
                            EmptyView()
                        @unknown default:
                            EmptyView()
                    }
                }
                if sizeClass != .compact {
                    List(fetchRequest) { section in
                        Section(header: Text(section.id).foregroundColor(.accentColor)) {
                            ForEach(section, id: \.self) { session in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(session.timerange!)")
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("\(session.group?.acronym ?? "")")
                                            .foregroundColor(.primary)
                                            .font(.subheadline)
                                    }
                                    Text(session.name!)
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                }
            }
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(location.name!)").bold()
                }
            }
        }
    }
}