import struct Foundation.UUID
import class ObjectLibrary.Contact
import enum ObjectLibrary.State
import enum ObjectLibrary.InputField

protocol ContactDetailModelDelegate: class {
    /// A helper method to notify the delegate that a save operation is enabled/disabled.
    func save(isEnabled: Bool)
    
}

final class ContactDetailModel {
    // MARK: - Properties
    
    private(set) var contact: Contact
    private weak var delegate: ContactDetailModelDelegate?
    
    init(contact: Contact, delegate: ContactDetailModelDelegate) {
        self.contact = contact
        self.delegate = delegate
    }
    
    // MARK: - Public methods for use by `ContactDetailViewController`
    
    /**
     // TODO: - If you have any methods, write them here
     -
     // HINT: - You will need at least one for managing input.
     -
     Take note of the private(set) on the `Contact` object above. `ctrl + cmd + click` on it to
     see what public methods are available for accessing or manipulating the values on the object.
     Notice that the `value(for inputField:)` instance function returns a `String?`, and that the
     instance function copy(withNewValue value:,for inputField:) accepts a `String` and `Inputfield`
     as parameters. This implies that you will have to tranform data submitted to, or consumed by,
     the `Contact` object for the `isEmergencyContact` (`Bool`) and `Address.state` (`State?`)
     attributes. Execute the following for insight into appropriately transforming the data back and
     forth:
     
     ```
     let booleans = [true, false]
     booleans.forEach {
        let description = $0.description
        let descriptionType = type(of: description)
        print("description: \(descriptionType) = \(description)")
     }
     
     let booleansFromStrings = [Bool("true"), Bool("false")]
     booleansFromStrings.forEach {
        let value = $0
        let valueType = type(of: value)
        print("value: \(valueType) = \(value)")
     }
     
     let state = State.alabama
     let stateType = type(of: state)
     print("state: \(stateType) = \(state)")
     
     let rawValue = state.rawValue
     let rawValueType = type(of: rawValue)
     print("rawValue: \(rawValueType) = \(rawValue)")
     ```
     */
    
    
}

// MARK: - Private helper methods

extension ContactDetailModel {
    private func isValid(contact: Contact) -> Bool {
        
        
        /**
         // TODO: - Implement this method to validate the 'contact' parameter
         -
         // HINT: -
         -
         - Use the `isValid(value:)` function you will write in `InputField.swift` to
         aid your validation. Inspect the `InputField` enum and note that it is `CaseIterable`.
         Lastly; be sure to remember that a `Contact` who is `isEmpty` is NOT a valid `Contact`.
         */
        
        
        return false
    }
}
