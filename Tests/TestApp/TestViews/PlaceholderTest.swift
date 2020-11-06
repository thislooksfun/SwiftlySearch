import SwiftUI

struct PlaceholderTest: View {
    @State
    var searchString = ""
    @State
    var placeholder = ""

    var body: some View {
        List {
            Button(action: {
                self.placeholder = "\(Date().timeIntervalSince1970)"
            }) {
                Text("Update placeholder")
                    .foregroundColor(.accentColor)
            }
            .accessibility(identifier: "placeholder button")

            Text("Expected placeholder: '\(placeholder)'")
        }
        .navigationBarTitle("Placeholder Test")
        .navigationBarSearch($searchString, placeholder: placeholder)
    }
}

struct PlaceholderTest_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderTest()
    }
}
