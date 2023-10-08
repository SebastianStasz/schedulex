// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Add group
  public static let addGroup = L10n.tr("Localizable", "add_group", fallback: "Add group")
  /// Add to observed
  public static let addToObserved = L10n.tr("Localizable", "add_to_observed", fallback: "Add to observed")
  /// Calendar
  public static let calendar = L10n.tr("Localizable", "calendar", fallback: "Calendar")
  /// Classes
  public static let classes = L10n.tr("Localizable", "classes", fallback: "Classes")
  /// Confirm
  public static let confirmButton = L10n.tr("Localizable", "confirm_button", fallback: "Confirm")
  /// Done
  public static let doneButton = L10n.tr("Localizable", "done_button", fallback: "Done")
  /// Events
  public static let events = L10n.tr("Localizable", "events", fallback: "Events")
  /// Faculties
  public static let faculties = L10n.tr("Localizable", "faculties", fallback: "Faculties")
  /// Faculty or group
  public static let facultyOrGroupPrompt = L10n.tr("Localizable", "faculty_or_group_prompt", fallback: "Faculty or group")
  /// For everyone
  public static let forEveryoneHeader = L10n.tr("Localizable", "for_everyone_header", fallback: "For everyone")
  /// Group
  public static let group = L10n.tr("Localizable", "group", fallback: "Group")
  /// Hidden
  public static let hidden = L10n.tr("Localizable", "hidden", fallback: "Hidden")
  /// Let's start
  public static let letsStart = L10n.tr("Localizable", "lets_start", fallback: "Let's start")
  /// To get started, select the groups you want to follow and see on the home page
  public static let letsStartMessage = L10n.tr("Localizable", "lets_start_message", fallback: "To get started, select the groups you want to follow and see on the home page")
  /// My groups
  public static let myGroups = L10n.tr("Localizable", "my_groups", fallback: "My groups")
  /// Next
  public static let nextButton = L10n.tr("Localizable", "next_button", fallback: "Next")
  /// No events here
  public static let noEventsMessage = L10n.tr("Localizable", "no_events_message", fallback: "No events here")
  /// No results found
  public static let noResultMessage = L10n.tr("Localizable", "no_result_message", fallback: "No results found")
  /// Number of classes:
  public static let numberOfClasses = L10n.tr("Localizable", "number_of_classes", fallback: "Number of classes:")
  /// Number of events:
  public static let numberOfEvents = L10n.tr("Localizable", "number_of_events", fallback: "Number of events:")
  /// Observed
  public static let observedTitle = L10n.tr("Localizable", "observed_title", fallback: "Observed")
  /// Other
  public static let otherHeader = L10n.tr("Localizable", "other_header", fallback: "Other")
  /// Selected date
  public static let selectedDate = L10n.tr("Localizable", "selected_date", fallback: "Selected date")
  /// Set visibility of classes
  public static let setClassesVisibility = L10n.tr("Localizable", "set_classes_visibility", fallback: "Set visibility of classes")
  /// Available groups
  public static let startFirstStepAllGroups = L10n.tr("Localizable", "start_first_step_all_groups", fallback: "Available groups")
  /// No groups selected
  public static let startFirstStepNoGroups = L10n.tr("Localizable", "start_first_step_no_groups", fallback: "No groups selected")
  /// Group name
  public static let startFirstStepPrompt = L10n.tr("Localizable", "start_first_step_prompt", fallback: "Group name")
  /// Selected
  public static let startFirstStepSelected = L10n.tr("Localizable", "start_first_step_selected", fallback: "Selected")
  /// Select groups
  public static let startFirstStepTitle = L10n.tr("Localizable", "start_first_step_title", fallback: "Select groups")
  /// Select languages
  public static let startSecondStepTitle = L10n.tr("Localizable", "start_second_step_title", fallback: "Select languages")
  /// Today
  public static let today = L10n.tr("Localizable", "today", fallback: "Today")
  /// Unfollow
  public static let unfollow = L10n.tr("Localizable", "unfollow", fallback: "Unfollow")
  /// Do you want to unfollow group
  public static let unfollowGroupQuestion = L10n.tr("Localizable", "unfollow_group_question", fallback: "Do you want to unfollow group")
  /// Visible
  public static let visible = L10n.tr("Localizable", "visible", fallback: "Visible")
  /// events
  public static let xEvents = L10n.tr("Localizable", "x_events", fallback: "events")
  /// groups
  public static let xGroups = L10n.tr("Localizable", "x_groups", fallback: "groups")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
