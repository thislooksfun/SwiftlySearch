# SwiftlySearch

A small, lightweight UISearchController wrapper for SwiftUI

## Usage

```swift
import SwiftlySearch

struct MRE: View {
  let items: [String]

  @State
  var searchText = ""

  var body: some View {
    NavigationView {
      List(items.filter { $0.localizedStandardContains(searchText) }) { item in
        Text(item)
      }.navigationBarSearch(self.$searchText)
    }
  }
}
```
