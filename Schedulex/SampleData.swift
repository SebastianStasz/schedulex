//
//  SampleData.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 01/08/2023.
//

import Domain
import Foundation

extension Faculty {
    static let sample = Faculty(name: "Applied Informatics", type: .faculty, groups: FacultyGroup.samples)
}

extension FacultyGroup {
    static let sample = FacultyGroup(name: "ZIIAS1-1111", numberOfEvents: 208, facultyDocument: "Applied Informatics", facultyUrl: .facultyUrl)

    static var samples: [FacultyGroup] {
        [FacultyGroup(name: "ZIIAS1-1111", numberOfEvents: 208, facultyDocument: "Applied Informatics", facultyUrl: ""),
         FacultyGroup(name: "ZIIAS1-1112", numberOfEvents: 145, facultyDocument: "Applied Informatics", facultyUrl: ""),
         FacultyGroup(name: "ZIIAS1-1113", numberOfEvents: 231, facultyDocument: "Applied Informatics", facultyUrl: "")]
    }
}

extension FacultyGroupClass {
    static let sample = FacultyGroupClass(name: "Organizacja i zarządzanie", type: "wykład", teacher: "Janusz Morajda")
}

extension Event {
    static let sample = Event(name: .eventName,
                              type: "wykład do wyboru",
                              startDate: .now,
                              endDate: Calendar.current.date(byAdding: .minute, value: 1, to: .now)!,
                              place: .place,
                              isRemoteClass: false,
                              isEventTransfer: false,
                              teacher: .teacher,
                              teacherProfileUrl: .profileUrl,
                              facultyGroup: "ZIIAS1-1111")

    static let sample2 = Event(name: "Historia myśli ekonomicznej",
                               type: "ćwiczenia",
                               startDate: Calendar.current.date(byAdding: .minute, value: 2, to: .now)!,
                               endDate: Calendar.current.date(byAdding: .minute, value: 3, to: .now)!,
                               place: .place,
                               isRemoteClass: false,
                               isEventTransfer: false,
                               teacher: .teacher,
                               teacherProfileUrl: .profileUrl,
                               facultyGroup: "ZIIAS1-1111")

    static let sample3 = Event(name: "Prognozowanie procesów ekonomicznych",
                               type: "ćwiczenia",
                               startDate: Calendar.current.date(byAdding: .minute, value: 4, to: .now)!,
                               endDate: Calendar.current.date(byAdding: .minute, value: 5, to: .now)!,
                               place: .place,
                               isRemoteClass: false,
                               isEventTransfer: false,
                               teacher: .teacher,
                               teacherProfileUrl: .profileUrl,
                               facultyGroup: "ZIIAS1-1111")

    static let eventTransfer = Event(name: .eventName, type: "Przeniesienie zajęć", startDate: .now, endDate: .now, place: .place, isRemoteClass: true, isEventTransfer: true, note: "na 17.01.2024", teacher: .teacher, teacherProfileUrl: .profileUrl, facultyGroup: "ZIIAS1-1111")
}

extension FacultyGroupEvent {
    static let sample = FacultyGroupEvent(facultyGroupName: "ZIIAS1-1111", color: .orange, event: .sample)
    static let sample2 = FacultyGroupEvent(facultyGroupName: "ZIIAS1-1111", color: .orange, event: .sample2)
    static let sample3 = FacultyGroupEvent(facultyGroupName: "ZIIAS1-1111", color: .orange, event: .sample3)
}

private extension String {
    static let eventName = "Probability and Statistics"
    static let place = "Paw.A 117 lab. Win10, Office21"
    static let teacher = "prof. UEK dr hab. Grażyna Paliwoda-Pękosz"
    static let facultyUrl = "https://planzajec.uek.krakow.pl/index.php?typ=G&id=237681&okres=2"
}

private extension URL {
    static let profileUrl = URL(string: "https://e-uczelnia.uek.krakow.pl/course/view.php?id=443#section-0")!
}
