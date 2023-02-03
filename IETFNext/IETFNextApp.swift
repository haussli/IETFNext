//
//  IETFNextApp.swift
//  IETFNext
//
//  Created by Tom Pusateri on 11/27/22.
//

import SwiftUI
import AppKit

public enum SidebarOption: String {
    case bcp
    case download
    case fyi
    case groups
    case locations
    case rfc
    case schedule
    case std
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#endif

@main
struct IETFNextApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    @State private var showingMeetings = false
    @State var menuSidebarOption: SidebarOption? = nil
    @State var useLocalTime: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView(showingMeetings: $showingMeetings, menuSidebarOption: $menuSidebarOption, useLocalTime: $useLocalTime)
                .environment(\.managedObjectContext, RFCProvider.shared.container.viewContext)
#if os(macOS)
                .frame(
                    minWidth: 1200,
                    idealWidth: 1800,
                    maxWidth: .infinity,
                    minHeight: 700,
                    idealHeight: 1500,
                    maxHeight: .infinity
                )
#endif
        }
#if os(macOS)
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle(showsTitle: false))
        //.windowStyle(HiddenTitleBarWindowStyle())
#endif
        .commands {
            SidebarCommands()
#if os(macOS)
            CommandGroup(replacing: .appInfo) {
                Button("About IETF Next") {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "git: \(Git.kRevisionNumber)",
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): "© 2022, Thomas Pusateri"
                        ]
                    )
                }
            }
            CommandGroup(replacing: .newItem) {
            }
            CommandGroup(replacing: .help) {
            }
            CommandMenu("Meeting") {
                Button(action: {
                    showingMeetings.toggle()
                }) {
                    Image(systemName: "airplane.departure")
                    Text("Change Meeting")
                }
                .keyboardShortcut("a")
                Toggle("Use Local Time", isOn: $useLocalTime)
            }
            CommandMenu("Go") {
                Button(action: {
                    menuSidebarOption = .schedule
                }) {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
                .keyboardShortcut("s")
                Button(action: {
                    menuSidebarOption = .groups
                }) {
                    Image(systemName: "person.3")
                    Text("Working Groups")
                }
                .keyboardShortcut("g")
                Button(action: {
                    menuSidebarOption = .locations
                }) {
                    Image(systemName: "map")
                    Text("Venue & Room Locations")
                }
                .keyboardShortcut("l")
                Button(action: {
                    menuSidebarOption = .rfc
                }) {
                    Image(systemName: "doc.plaintext")
                    Text("RFCs")
                }
                .keyboardShortcut("r")
                Button(action: {
                    menuSidebarOption = .bcp
                }) {
                    Image(systemName: "doc.plaintext")
                    Text("BCPs")
                }
                .keyboardShortcut("b")
                Button(action: {
                    menuSidebarOption = .fyi
                }) {
                    Image(systemName: "doc.plaintext")
                    Text("FYIs")
                }
                Button(action: {
                    menuSidebarOption = .std
                }) {
                    Image(systemName: "doc.plaintext")
                    Text("STDs")
                }
                Button(action: {
                    menuSidebarOption = .download
                }) {
                    Image(systemName: "arrow.down.circle")
                    Text("Downloads")
                }
                .keyboardShortcut("d")
            }
#endif
        }
    }
}
