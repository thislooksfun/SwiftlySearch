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
