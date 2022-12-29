//
//  LocationListView.swift
//  IETFNext
//
//  Created by Tom Pusateri on 11/28/22.
//

import SwiftUI
import CoreData


let venuePhotos = [
    "116": "https://www.pacifico.co.jp/Portals/0/images/en/index/kv/kv_01re.jpg",
    "115": "https://weekender-hotel-api-2.imgix.net/hotel-images/20170206-LONMETW-hotel-banner-1.jpg?auto=format&q=50&w=1200&dpr=1.5",
    "114": "https://cache.marriott.com/content/dam/marriott-renditions/PHLWS/phlws-exterior-0091-hor-clsc.jpg",
    "113": "https://www.hilton.com/im/en/VIEHITW/14562339/hilton-vienna-exterior.jpg?impolicy=crop&cw=4517&ch=2540&gravity=NorthWest&xposition=0&yposition=229&rw=1214&rh=683",
    "106": "https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/203/2019/11/08031528/fairmont-singapore-night-view.jpg",
]


struct LocationListView: View {
    @Environment(\.managedObjectContext) private var viewContext
#if !os(macOS)
    @Environment(\.horizontalSizeClass) var hSizeClass
#endif
    @SectionedFetchRequest<String, Location> var fetchRequest: SectionedFetchResults<String, Location>
    @Binding var selectedLocation: Location?
    @Binding var selectedMeeting: Meeting?
    @Binding var html: String
    @Binding var title: String
    @Binding var columnVisibility: NavigationSplitViewVisibility


    init(selectedMeeting: Binding<Meeting?>, selectedLocation: Binding<Location?>, html: Binding<String>, title: Binding<String>, columnVisibility: Binding<NavigationSplitViewVisibility>) {
        _fetchRequest = SectionedFetchRequest<String, Location>(
            sectionIdentifier: \.level_name!,
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Location.level_name, ascending: true),
                NSSortDescriptor(keyPath: \Location.name, ascending: true),
            ],
            predicate: NSPredicate(format: "meeting.number = %@", selectedMeeting.wrappedValue?.number ?? "0"),
            animation: .default
        )
        self._selectedMeeting = selectedMeeting
        self._selectedLocation = selectedLocation
        self._html = html
        self._title = title
        self._columnVisibility = columnVisibility
    }

    private func escapedAddress(meeting: Meeting) -> String? {
        if let venue_addr = meeting.venue_addr {
            return venue_addr
                .replacingOccurrences(of: "\r\n", with: ",")
                .replacingOccurrences(of: " ,", with: ",")
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        } else {
            return nil
        }
    }

    var body: some View {
        List(fetchRequest, selection: $selectedLocation) { section in
            Section(header: Text(section.id).foregroundColor(.accentColor)) {
                ForEach(section, id: \.self) { location in
                    HStack {
                        Text(location.name ?? "Unknown")
                            .foregroundColor(.primary)
                        Spacer()
                        if location.sessions?.count ?? 0 == 1 {
                            Text("1 Session")
                                .foregroundColor(.secondary)
                        } else {
                            Text("\(location.sessions?.count ?? 0) Sessions")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
#if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let meeting = selectedMeeting {
                    if let venue = meeting.venue_name {
                        VStack {
                            Text("Rooms")
                                .font(.headline)
                            Text(venue)
                                .font(.subheadline)
                        }
                    }
                }
            }
            ToolbarItem {
                Menu {
                    if !UIDevice.isIPhone {
                        if let meeting = selectedMeeting {
                            if let _ = venuePhotos[meeting.number!] {
                                Button(action: {
                                    selectedLocation = nil
                                }) {
                                    Label("Show Venue Photo", systemImage: "photo")
                                }
                            }
                        }
                    }
                    Button(action: {
                        if let meeting = selectedMeeting {
                            if let addr = escapedAddress(meeting: meeting) {
                                let urlString = "https://maps.apple.com/?address=\(addr)"
                                guard let url = URL(string: urlString) else {
                                    print("Invalid venue address URL: \(urlString)")
                                    return
                                }
#if os(macOS)
                                NSWorkspace.shared.open(url)
#else
                                UIApplication.shared.open(url)
#endif
                            }
                        }
                    }) {
                        Label("Show Venue on Map", systemImage: "mappin.and.ellipse")
                    }
                    .disabled(selectedMeeting?.venue_addr?.isEmpty ?? true)
                    Button(action: {
                        if let meeting = selectedMeeting {
                            if let addr = escapedAddress(meeting: meeting) {
                                let urlString = "https://maps.apple.com/?daddr=\(addr)"
                                guard let url = URL(string: urlString) else {
                                    print("Invalid venue address URL: \(urlString)")
                                    return
                                }
#if os(macOS)
                                NSWorkspace.shared.open(url)
#else
                                UIApplication.shared.open(url)
#endif
                            }
                        }
                    }) {
                        Label("Directions to Venue", systemImage: "mappin.and.ellipse")
                    }
                    .disabled(selectedMeeting?.venue_addr?.isEmpty ?? true)
                }
                label: {
                    Label("Map", systemImage: "map")
                }
            }
#if !os(macOS)
            ToolbarItem(placement: .bottomBar) {
                if let meeting = selectedMeeting {
                    if let number = meeting.number {
                        if let city = meeting.city {
                            Text("IETF \(number) (\(city))")
                                .font(.subheadline)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
#endif
        }
        .onChange(of: selectedMeeting) { newValue in
            if let meeting = newValue {
                fetchRequest.nsPredicate = NSPredicate(format: "meeting.number = %@", meeting.number!)
            }
        }
        .onAppear {
            html = BLANK
            if columnVisibility == .all {
                columnVisibility = .doubleColumn
            }
        }
    }
}
