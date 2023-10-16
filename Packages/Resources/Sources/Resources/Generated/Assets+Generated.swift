// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

public extension Color {
  // Colors.xcassets
  static var blueShade1 : Color { Color("blue_shade_1", bundle: .module) }
  static var blueShade2 : Color { Color("blue_shade_2", bundle: .module) }
  static var blueShade3 : Color { Color("blue_shade_3", bundle: .module) }
  static var blueShade4 : Color { Color("blue_shade_4", bundle: .module) }
  static var yellowShade1 : Color { Color("yellow_shade_1", bundle: .module) }
  static var accentPrimary : Color { Color("accent_primary", bundle: .module) }
  static var backgroundPrimary : Color { Color("background_primary", bundle: .module) }
  static var backgroundSecondary : Color { Color("background_secondary", bundle: .module) }
  static var backgroundTertiary : Color { Color("background_tertiary", bundle: .module) }
  static var grayShade1 : Color { Color("gray_shade_1", bundle: .module) }
  static var greenPrimary : Color { Color("green_primary", bundle: .module) }
  static var textPrimary : Color { Color("text_primary", bundle: .module) }
}

public extension UIColor {
    static let blueShade1 = UIColor(named: "blue_shade_1", in: .module, compatibleWith: .current)!
    static let blueShade2 = UIColor(named: "blue_shade_2", in: .module, compatibleWith: .current)!
    static let blueShade3 = UIColor(named: "blue_shade_3", in: .module, compatibleWith: .current)!
    static let blueShade4 = UIColor(named: "blue_shade_4", in: .module, compatibleWith: .current)!
    static let yellowShade1 = UIColor(named: "yellow_shade_1", in: .module, compatibleWith: .current)!
    static let accentPrimary = UIColor(named: "accent_primary", in: .module, compatibleWith: .current)!
    static let textPrimary = UIColor(named: "text_primary", in: .module, compatibleWith: .current)!
}

public extension Image {
  // Colors.xcassets
}

public extension UIImage {
}

private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
