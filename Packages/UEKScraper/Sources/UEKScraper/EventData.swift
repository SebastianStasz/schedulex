//
//  EventData.swift
//  UEKScraper
//
//  Created by Sebastian Staszczyk on 23/12/2023.
//

import Domain
import Foundation

struct EventData {
    let name: String?
    let type: String?
    let date: String
    let time: String
    let place: String?
    let teacher: String?
    let teacherProfileLink: String?
    let teamsLink: String?
    var eventTransferNote: String?

    private var teacherProfileUrl: URL? {
        guard let teacherProfileLink else { return nil }
        return URL(string: teacherProfileLink)
    }

    private var teamsUrl: URL? {
        guard let teamsLink else { return nil }
        return URL(string: teamsLink)
    }

    private var isLanguageEvent: Bool {
        name?.contains("grupa przedmiotów") ?? false || place == "Wybierz swoją grupę językową" || type == "lektorat"
    }

    private var isValidClass: Bool {
        teacher != "Studencki Uek Parlament" && type != "rezerwacja" && type != "Przeniesienie zajęć"
    }

    var isEventTransfer: Bool {
        type == "Przeniesienie zajęć"
    }

    func isValidEvent(for facultyGroup: FacultyGroup) -> Bool {
        !(!facultyGroup.isLanguage && isLanguageEvent)
    }

    func toEvent(facultyGroup: FacultyGroup, datesDecoder: DatesDecoder) -> Event {
        let dates = datesDecoder.getDates(date: date, time: time)
        return Event(facultyGroupName: facultyGroup.name, facultyGroupColor: facultyGroup.color, isEventTransfer: isEventTransfer, eventTransferNote: eventTransferNote, startDate: dates.0, endDate: dates.1, name: name, place: place, teacher: teacher, teacherProfileUrl: teacherProfileUrl, teamsUrl: teamsUrl, type: type)
    }

    func toFacultyGroupClass() -> FacultyGroupClass? {
        guard let name, let type, let teacher, isValidClass else { return nil }
        return FacultyGroupClass(name: name, type: type, teacher: teacher)
    }
}
