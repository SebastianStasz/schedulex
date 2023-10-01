// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Calendar
  public static let calendar = L10n.tr("Localizable", "calendar", fallback: "Calendar")
  /// Faculties
  public static let faculties = L10n.tr("Localizable", "faculties", fallback: "Faculties")
  /// Faculty or group
  public static let facultyOrGroupPrompt = L10n.tr("Localizable", "faculty_or_group_prompt", fallback: "Faculty or group")
  /// For everyone
  public static let forEveryoneHeader = L10n.tr("Localizable", "for_everyone_header", fallback: "For everyone")
  /// Group
  public static let group = L10n.tr("Localizable", "group", fallback: "Group")
  /// My groups
  public static let myGroups = L10n.tr("Localizable", "my_groups", fallback: "My groups")
  /// No events here
  public static let noEventsMessage = L10n.tr("Localizable", "no_events_message", fallback: "No events here")
  /// Observed
  public static let observedTitle = L10n.tr("Localizable", "observed_title", fallback: "Observed")
  /// Other
  public static let otherHeader = L10n.tr("Localizable", "other_header", fallback: "Other")
  /// Selected date
  public static let selectedDate = L10n.tr("Localizable", "selected_date", fallback: "Selected date")
  /// Today
  public static let today = L10n.tr("Localizable", "today", fallback: "Today")
  /// Unfollow
  public static let unfollow = L10n.tr("Localizable", "unfollow", fallback: "Unfollow")
  /// Do you want to unfollow group
  public static let unfollowGroupQuestion = L10n.tr("Localizable", "unfollow_group_question", fallback: "Do you want to unfollow group")
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
