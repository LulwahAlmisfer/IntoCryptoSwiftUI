

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
      let title: LocalizedStringResource
    let value: String
    let percentageChange: Double?
    
    init( title : LocalizedStringResource, value: String, percentageChange: Double? = nil) {
       self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
