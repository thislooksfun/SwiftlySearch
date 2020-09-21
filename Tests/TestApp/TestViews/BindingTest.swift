import SwiftUI

struct BindingTest: View {
    @State
    var searchString = ""

    var body: some View {
        List {
            Button(action: {
                self.searchString = "\(Date().timeIntervalSince1970)"
            }) {
                Text("Update value")
                    .foregroundColor(.accentColor)
            }
            .accessibility(identifier: "state button")
        }
        .navigationBarTitle("Binding Test")
        .navigationBarSearch($searchString)
    }
}

struct BindingTest_Previews: PreviewProvider {
    static var previews: some View {
        BindingTest()
    }
}
