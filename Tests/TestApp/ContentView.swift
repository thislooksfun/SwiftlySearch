import SwiftUI

struct ContentView: View {
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
        NavigationView {
            List(arr.filter { searchString.isEmpty || $0.localizedStandardContains(searchString) }, id: \.self) { str in
                Text(str)
            }
            .navigationBarTitle("Test App")
            .navigationBarItems(trailing:
                Button(action: {
                    self.searchString = "yay"
                }) {
                    Text("Btn")
                }
                .accessibility(identifier: "state button")
            )
            .navigationBarSearch($searchString)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
