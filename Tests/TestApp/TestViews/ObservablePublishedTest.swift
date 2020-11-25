import SwiftUI

class ObservablePublishedModel: ObservableObject {
    @Published var searchText = ""
}

struct ObservablePublishedTest: View {
    @ObservedObject var viewModel = ObservablePublishedModel()

    var body: some View {
        List {
            Text("foo")
        }
        .navigationBarSearch($viewModel.searchText)
    }
}

struct ObservablePublishedTest_Previews: PreviewProvider {
    static var previews: some View {
        ObservablePublishedTest()
    }
}
