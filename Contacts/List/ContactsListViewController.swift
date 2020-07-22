import UIKit
import class ObjectLibrary.Contact

final class ContactsListViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var model: ContactsListModel!
    
    /**
     Programmatically instantiated controller for managing a search interface
     
     The following convenience variables aid in interfacing with the `UISearchbar` by:
     - Storing a reference to the `UISearchbar` (searchController)
     - Indicating whether it is active and being utilized at a given moment (isFiltering)
     */
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltering: Bool { searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ContactsListModel()
        configureSearchController()
        
    }
    
    // MARK: - Prepare method for segue to ContactDetail page
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let contactDetailViewController = segue.destination as? ContactDetailViewController else { return }

        let contact = sender as? Contact ?? Contact.instance()
        let model = ContactDetailModel(contact: contact, delegate: contactDetailViewController)
        contactDetailViewController.setup(model: model, delegate: self)
    }
}

// MARK: - Private helper method for configuring the `UISearchBar`

extension ContactsListViewController {
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDelegate

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: model.contact(for: indexPath, isFiltering: isFiltering))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ContactsListViewController: UITableViewDataSource {
    /// This method tells the `UITableView` how many sections it must create.
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = model.numberOfSections(isFiltering: isFiltering)
        
        /// The following adds a visual indicator for the event of an empty list.
        if numberOfSections == 0 {
            tableView.addEmptyListLabel(withText: "No Contacts", adjustSeparatorStyle: true)
        } else {
            tableView.removeEmptyListLabel()
        }
        
        return numberOfSections
    }
    
    /// This required method tells the `UITableView` the `numberOfRows` in a sepcified section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows(in: section, isFiltering: isFiltering)
    }
    
    /**
     This required method is utilized to supply the `UITableView` with the appropriate `UITableViewCell`
     for a given `IndexPath`.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact") as! ContactsListTableViewCell
        cell.setup(contact: model.contact(for: indexPath, isFiltering: isFiltering))

        return cell
    }
    
    /**
     This method supplies the `UITableView` with the appropriate title for a given section.
     
     __ex:__ 'A', 'B', '#', *etc*
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.titleForHeader(in: section, isFiltering: isFiltering)
    }

    /**
     This method supplies the `UITableView` with the appropriate index titles.
     In other words; it tells the 'UITableview' the titles for the index buttons
     located to the right of the 'UITableview' (in order).
     */
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return model.sectionIndexTitles
    }
    
    /**
     This method connects the index title on the right of the `UITableView` to its corresponding
     section within the `UITableView` itself.
     */
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return model.section(for: title, index: index, isFiltering: isFiltering)
    }
}

// MARK: - UISearchResultsUpdating

extension ContactsListViewController: UISearchResultsUpdating {
    /// This method is called when text in the `UISearchBar` changes.
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        model.filterContentForSearchText(text)
        tableView.reloadData()
    }
}

// MARK: - ContactDetailViewControllerDelegate

extension ContactsListViewController: ContactDetailViewControllerDelegate {
    func add(_ contact: Contact) {
        model.add(contact)
        updateSearchResults(for: searchController)
        navigationController?.popViewController(animated: true)
    }
}
