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
    let teamsLink: String?
    let facultyGroup: String?
    let teacherProfileLink: String?
    var note: String?

    private var teacherProfileUrl: URL? {
        guard let teacherProfileLink else { return nil }
        return URL(string: teacherProfileLink)
    }

    private var teamsUrl: URL? {
        guard let teamsLink else { return nil }
        return URL(string: teamsLink)
    }

    private var isLanguageEvent: Bool {
        name?.contains("Język obcy") ?? false || place == "Wybierz swoją grupę językową" || type == "lektorat"
    }

    private var isValidClass: Bool {
        teacher != "Studencki Uek Parlament" && type != "rezerwacja" && type != "Przeniesienie zajęć"
    }

    private var isRemoteClass: Bool {
        place == "link do zajęć"
    }

    var isEventTransfer: Bool {
        type == "Przeniesienie zajęć"
    }

    func isValidEvent(omitLanguageClasses: Bool) -> Bool {
        if omitLanguageClasses { return !isLanguageEvent }
        return true
    }

    func toEvent(datesDecoder: DatesDecoder) -> Event? {
        guard let (startDate, endDate) = datesDecoder.getDates(date: date, time: time) else { return nil }
        return Event(name: name, type: type, startDate: startDate, endDate: endDate, place: place, teamsUrl: teamsUrl, isRemoteClass: isRemoteClass, isEventTransfer: isEventTransfer, note: note, teacher: teacher, teacherProfileUrl: teacherProfileUrl, facultyGroup: facultyGroup)
    }

    func toFacultyGroupClass() -> FacultyGroupClass? {
        guard let name, let type, let teacher, isValidClass else { return nil }
        return FacultyGroupClass(name: name, type: type, teacher: teacher)
    }
}
