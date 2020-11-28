import Combine
import SwiftUI

class ObservablePublishedModel: ObservableObject {
    @Published var searchText = ""
    @Published var updateCount = 0
    var cancellable: Cancellable?

    init() {
        cancellable = $searchText
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink() { [weak self] _ in self?.updateCount += 1 }
    }
}

struct ObservablePublishedTest: View {
    @ObservedObject var viewModel = ObservablePublishedModel()

    var body: some View {
        List {
            Text("Update count: \(viewModel.updateCount)")
                .accessibility(identifier: "countLabel")
        }
        .navigationBarSearch($viewModel.searchText)
    }
}

struct ObservablePublishedTest_Previews: PreviewProvider {
    static var previews: some View {
        ObservablePublishedTest()
    }
}
