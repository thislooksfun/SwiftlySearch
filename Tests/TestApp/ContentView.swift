import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SearchTest()) {
                    Text("Search")
                }

                NavigationLink(destination: BindingTest()) {
                    Text("Binding")
                }

                NavigationLink(destination: PlaceholderTest()) {
                    Text("Placeholder")
                }

                NavigationLink(destination: CallbackUpdateTest()) {
                    Text("Callback Update")
                }
            }
            .navigationBarTitle("Tests")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
