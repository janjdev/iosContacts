import UIKit
import class ObjectLibrary.Contact

// MARK: - `UITableViewCell` subclass used by `ContactsListViewController` to display data

final class ContactsListTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emergencyImageView: UIImageView!
}

// MARK: - Convenience setup method

extension ContactsListTableViewCell {
    func setup(contact: Contact) {
        titleLabel.attributedText = contact.attributedDisplayText
        emergencyImageView.isHidden = !contact.isEmergencyContact
    }
}
