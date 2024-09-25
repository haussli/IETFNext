/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Manages reading and writing data from the event store.
*/

import EventKit

actor EventDataStore {
    nonisolated let eventStore: EKEventStore
            
    init() {
        self.eventStore = EKEventStore()
    }
}
