import SwiftUI

struct SearchTest: View {
    private let arr = [
        "hi",
        "hello there",
        "testing stuff!",
        "Yay!",
        "Special characters: 😄",
    ]

    @State
    var searchString = ""

    var body: some View {
        List(arr.filter { searchString.isEmpty || $0.localizedStandardContains(searchString) }, id: \.self) { str in
            Text(str)
        }
        .navigationBarTitle("Search Test")
        .navigationBarSearch($searchString)
    }
}

struct SearchTest_Previews: PreviewProvider {
    static var previews: some View {
        SearchTest()
    }
}
