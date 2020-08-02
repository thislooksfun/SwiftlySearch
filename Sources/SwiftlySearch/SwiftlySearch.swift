// Copyright © 2020 thislooksfun
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI
import Combine

public extension View {
    func navigationBarSearch(_ searchText: Binding<String>, placeholder: String? = nil, hidesNavigationBarDuringPresentation: Bool = true, hidesSearchBarWhenScrolling: Bool = true, searchClicked: @escaping () -> Void = {}) -> some View {
        return overlay(SearchBar<AnyView>(text: searchText, placeholder: placeholder, hidesNavigationBarDuringPresentation: hidesNavigationBarDuringPresentation, hidesSearchBarWhenScrolling: hidesSearchBarWhenScrolling, searchClicked: searchClicked).frame(width: 0, height: 0))
    }

    func navigationBarSearch<ResultContent: View>(_ searchText: Binding<String>, placeholder: String? = nil, hidesNavigationBarDuringPresentation: Bool = true, hidesSearchBarWhenScrolling: Bool = true, searchClicked: @escaping () -> Void = {}, @ViewBuilder resultContent: @escaping (String) -> ResultContent) -> some View {
        return overlay(SearchBar(text: searchText, placeholder: placeholder, hidesNavigationBarDuringPresentation: hidesNavigationBarDuringPresentation, hidesSearchBarWhenScrolling: hidesSearchBarWhenScrolling, searchClicked: searchClicked, resultContent: resultContent).frame(width: 0, height: 0))
    }
}

fileprivate struct SearchBar<ResultContent: View>: UIViewControllerRepresentable {
    @Binding
    var text: String
    let placeholder: String?
    let hidesNavigationBarDuringPresentation: Bool
    let hidesSearchBarWhenScrolling: Bool
    let searchClicked: () -> Void
    let resultContent: (String) -> ResultContent?

    init(text: Binding<String>, placeholder: String?, hidesNavigationBarDuringPresentation: Bool, hidesSearchBarWhenScrolling: Bool, searchClicked: @escaping () -> Void, @ViewBuilder resultContent: @escaping (String) -> ResultContent? = { _ in nil }) {
        self._text = text
        self.placeholder = placeholder
        self.hidesNavigationBarDuringPresentation = hidesNavigationBarDuringPresentation
        self.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
        self.searchClicked = searchClicked
        self.resultContent = resultContent
    }

    func makeUIViewController(context: Context) -> SearchBarWrapperController {
        return SearchBarWrapperController()
    }

    func updateUIViewController(_ controller: SearchBarWrapperController, context: Context) {
        controller.searchController = context.coordinator.searchController
        controller.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
        if let resultView = resultContent(text) {
            (controller.searchController?.searchResultsController as? UIHostingController<ResultContent>)?.rootView = resultView
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, placeholder: placeholder, hidesNavigationBarDuringPresentation: hidesNavigationBarDuringPresentation, resultContent: resultContent, searchClicked: searchClicked)
    }

    class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
        @Binding
        var text: String
        let searchClicked: () -> Void
        let searchController: UISearchController

        private var subscription: AnyCancellable?

        init(text: Binding<String>, placeholder: String?, hidesNavigationBarDuringPresentation: Bool, resultContent: (String) -> ResultContent?, searchClicked: @escaping () -> Void) {
            self._text = text
            self.searchClicked = searchClicked

            let resultView = resultContent(text.wrappedValue)
            let searchResultController = resultView.map { UIHostingController(rootView: $0) }
            self.searchController = UISearchController(searchResultsController: searchResultController)

            super.init()

            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = hidesNavigationBarDuringPresentation
            searchController.obscuresBackgroundDuringPresentation = false

            searchController.searchBar.delegate = self
            if let placeholder = placeholder {
                searchController.searchBar.placeholder = placeholder
            }

            self.searchController.searchBar.text = self.text
            self.subscription = self.text.publisher.sink { _ in
                self.searchController.searchBar.text = self.text
            }
        }

        deinit {
            self.subscription?.cancel()
        }

        // MARK: - UISearchResultsUpdating
        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }
            DispatchQueue.main.async {
                self.text = text
            }
        }


        // MARK: - UISearchBarDelegate
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.searchClicked()
        }
    }

    class SearchBarWrapperController: UIViewController {
        var searchController: UISearchController? {
            didSet {
                self.parent?.navigationItem.searchController = searchController
            }
        }

        var hidesSearchBarWhenScrolling: Bool = true {
            didSet {
                self.parent?.navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
            }
        }

        override func viewWillAppear(_ animated: Bool) {
            setup()
        }
        override func viewDidAppear(_ animated: Bool) {
            setup()
        }

        private func setup() {
            self.parent?.navigationItem.searchController = searchController
            self.parent?.navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling

            // make search bar appear at start (default behaviour since iOS 13)
            self.parent?.navigationController?.navigationBar.sizeToFit()
        }
    }
}
