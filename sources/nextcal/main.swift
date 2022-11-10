import EventKit

let store = EKEventStore()
let calendars = store.calendars(for: .event)

let today = Date(timeIntervalSinceNow: 0)
let oneWeekInFuture = Date(timeIntervalSinceNow: 7 * 24 * 60 * 60)

for calendar in calendars {
    if calendar.title != "Contacts" && calendar.title != "Birthdays" {
        let predicate = store.predicateForEvents(withStart: today, end: oneWeekInFuture, calendars: [calendar])
        let events = store.events(matching: predicate)

        if let firstEvent = events.first {
            let dayForToday = Calendar.current.dateComponents([.day], from: today)
            let dayForEvent = Calendar.current.dateComponents([.day], from: firstEvent.startDate)

            let formatter = DateFormatter()
            if dayForToday == dayForEvent {
                formatter.dateFormat = "h:mm a"
            } else {
                formatter.dateFormat = "MM/dd h:mm a"
            }

            print(formatter.string(from: firstEvent.startDate), terminator: "")
            print(": ", terminator: "")
            print(firstEvent.title ?? "")
        }
    }
}
