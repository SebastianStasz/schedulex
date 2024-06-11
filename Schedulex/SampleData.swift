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
    static let sample = Event(isEventTransfer: false, isRemoteClass: false, eventTransferNote: nil, startDate: .now, endDate: .now, name: .eventName, place: .place, teacher: .teacher, teacherProfileUrl: .profileUrl, teamsUrl: nil, type: "wykład do wyboru")
    static let eventTransfer = Event(isEventTransfer: true, isRemoteClass: true, eventTransferNote: "na 17.01.2024", startDate: .now, endDate: .now, name: .eventName, place: .place, teacher: .teacher, teacherProfileUrl: .profileUrl, teamsUrl: nil, type: "Przeniesienie zajęć")
}

extension FacultyGroupEvent {
    static let sample = FacultyGroupEvent(facultyGroupName: "ZIIAS1-1111", color: .blue, event: .sample)
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
