# SwiftlySearch

A small, lightweight UISearchController wrapper for SwiftUI

## Installation

### Manual:

Update your `Package.swift` file:

```swift
let package = Package(
  ...,

  dependencies: [
    .package(
      url: "https://github.com/thislooksfun/SwiftlySearch.git",
      from: "1.0.0"),

    ...
  ],

  ...
)
```

### In Xcode:

1. Go to File > Swift Packages > Add Package Depencency...
2. Enter `https://github.com/thislooksfun/SwiftlySearch` as the URL
3. Select your desired versioning constraint
4. Click Next
5. Click Finish

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
