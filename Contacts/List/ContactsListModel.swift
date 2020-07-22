import UIKit
import class ObjectLibrary.Contact

final class ContactsListModel {
    /**
     An object for managing a data-source
     
      A __UILocalizedIndexedCollation__ is an object that organizes, sorts, and localizes the data for a table view that has a section index
     
     ```
     // Determines the section in which each of these objects should appear and returns an integer that identifies the section
     func section(for:collationStringSelector:)
     
     // A method to sort all of the objects in the section
     func sortedArray(from:collationStringSelector:)
     
     // Returns the list of section titles for the table view
     var sectionTitles: [String]
     
     // Returns the list of section-index titles for the table view
     var sectionIndexTitles: [String]
     ```
     */
    private let collation = UILocalizedIndexedCollation.current()
    
    /**
     Master list of `Contact` objects. Note the use of `didSet` to ensure `sections` is sorted each time
     the data is manipulated.
     */
    private var contacts: [Contact] = [] { didSet { sortSections() }}
    
    /**
     Sectioned lists used by the `UITableView` as the primary data source based on the `isFiltering` boolean which indicates whether or not the `UISearchBar` is active.
     */
    
    private var sections: [Section] = []
    private var filteredSections: [Section] = []
    
    // MARK: - Convenience variables for use by the `UITableView`
    
    var sectionIndexTitles: [String] { collation.sectionIndexTitles }
    
    // MARK: - Convenience method for locating a `Contact` object given an `IndexPath`
    
    func contact(for indexPath: IndexPath, isFiltering: Bool) -> Contact {
        return sections(for: isFiltering)[indexPath.section].contacts[indexPath.row]
    }
    
    // MARK: - Convenience methods for use by the `UITableView`
    
    func numberOfSections(isFiltering: Bool) -> Int {
        return sections(for: isFiltering).count
    }
    
    func numberOfRows(in section: Int, isFiltering: Bool) -> Int {
        return sections(for: isFiltering)[section].contacts.count
    }
    
    func titleForHeader(in section: Int, isFiltering: Bool) -> String? {
        guard contacts.count > 5 else { return nil }
        
        return sections(for: isFiltering)[section].title
    }
    
    func section(for title: String, index: Int, isFiltering: Bool) -> Int {
        return sections(for: isFiltering).firstIndex(where: { $0.title == title }) ?? index
    }
    
    // MARK: - Public methods for manipulating the data source
    
    func filterContentForSearchText(_ searchText: String) {
        let searchTerms = searchText
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces)
            .filter { $0 != "" }
        
        filteredSections = sections.compactMap { $0.filtered(by: searchTerms) }
    }
    
    func add(_ contact: Contact) {
        /// `contacts` is manipulated, at most, 1 time per call to this method.
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        } else {
            contacts.append(contact)
        }
    }
}

// MARK: - Private helper methods

extension ContactsListModel {
    /// This method returns the appropriate `Section` array based upon the `isFiltering` predicate.
    private func sections(for isFiltering: Bool) -> [Section] {
        return isFiltering ? filteredSections : sections
    }
    
    /// This method utilizes `UILocalizedIndexedCollation` to sort the `contacts` array into alphabetical sections.
    private func sortSections() {
        let selector: Selector = #selector(getter: Contact.collationString)
        //swiftlint:disable:next force_cast
        let sortedContacts = collation.sortedArray(from: contacts, collationStringSelector: selector) as! [Contact]
        let sectionedContacts: [[Contact]] = sortedContacts.reduce(into: Array(repeating: [], count: collation.sectionTitles.count)) {
            let index = collation.section(for: $1, collationStringSelector: selector)
            
            $0[index].append($1)
        }
        
        sections = collation.sectionTitles.enumerated().compactMap {
            let contacts = sectionedContacts[$0.offset]
            return Section(title: $0.element, contacts: contacts)
        }
    }
}

// MARK: - Private helper struct

extension ContactsListModel {
    /// This struct stores/manipulates data concerning a given `UITableView` section.
    private struct Section {
        let title: String
        let contacts: [Contact]
        
        init?(title: String, contacts: [Contact]) {
            guard !contacts.isEmpty else { return nil }
            
            self.title = title
            self.contacts = contacts
        }

        func filtered(by searchTerms: [String]) -> Section? {
            let contacts = self.contacts.filter { $0.searchableStrings.containsAll(elements: searchTerms) }
            return Section(title: title, contacts: contacts)
        }
    }
}


