import SwiftUI

struct CallbackUpdateTest: View {
    @State
    var searchString = ""

    @State
    var doSearchTxt = "a"
    @State
    var doCancelTxt = "b"

    @State
    var doSearch = { }
    @State
    var doCancel = { }

    var body: some View {
        List {
            Button(action: {
                self.doSearch = { self.doSearchTxt = "1: \(Date().timeIntervalSince1970)" }
                self.doCancel = { self.doCancelTxt = "2: \(Date().timeIntervalSince1970)" }
            }) {
                Text("Update callbacks")
                    .foregroundColor(.accentColor)
            }
            .accessibility(identifier: "callbacks button")

            Text(doSearchTxt)
                .accessibility(identifier: "do search text")
            Text(doCancelTxt)
                .accessibility(identifier: "do cancel text")
        }
        .navigationBarTitle("Callback Update Test")
        .navigationBarSearch($searchString, cancelClicked: doCancel, searchClicked: doSearch)
    }
}

struct CallbackUpdateTest_Previews: PreviewProvider {
    static var previews: some View {
        CallbackUpdateTest()
    }
}
