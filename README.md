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


## Known issues:

([#12](https://github.com/thislooksfun/SwiftlySearch/issues/12)) `NavigationLink`s inside the `resultContent` don't work. This is a limitation of the UIKit/SwiftUI interaction, and thus out of my hands. If you require a seperate view for displaying search results you can use a workaround like shown below:
```swift
struct ContentView: View {
    @State
    var searchText: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                if searchText.isEmpty {
                    NormalView()
                } else {
                    SearchResultsView(text: searchText)
                }
            }
            .navigationBarSearch($searchText)
        }
    }
}

struct NormalView: View {
    var body: some View {
        Text("Some view")
    }
}

struct SearchResultsView: View {
    var text: String

    var body: some View {
        VStack {
            Text("You searched for \(text)")
            NavigationLink(destination: Text(text)) {
                Text("Let's go!")
            }
        }
    }
}
```
