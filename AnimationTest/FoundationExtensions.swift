
//

import UIKit

extension CGFloat {
    func degreeToRadians() -> CGFloat {
        return (self * .pi) / 180
    }
}

extension Double {
    func roundToPlaces(places: Int) -> Double{
        let divisor = Double(truncating: NSDecimalNumber(decimal: pow(10, places)))
        return ((divisor * self).rounded() / divisor)
    }
}
