import UIKit
import class ObjectLibrary.Contact
import enum ObjectLibrary.State
import enum ObjectLibrary.InputField

protocol ContactDetailViewControllerDelegate: class {
    func add(_ contact: Contact)
}

final class ContactDetailViewController: UIViewController {
    
    var contact: Contact?
    weak var delegate: ContactDetailModelDelegate?
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet var nameFields: [UITextField]!
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet var phoneNumFields: [UITextField]!
    
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var aptField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    
    @IBOutlet var addressFields: [UITextField]!
    
    @IBOutlet weak var uiLabel: UILabel!
    
    @IBOutlet weak var uiSwitch: UISwitch!
    var model: ContactDetailModel?
    // MARK: - Properties
    
    /**
     // TODO: - Declare any properties needed here
     -
     // HINT: - You will need at least a model and delegate.
     -
     */
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         // TODO: - Perform any additional setup after loading the view here
         -
         */
        model = ContactDetailModel(contact: Contact.instance(), delegate: self)
        
        
        
        setCorners(fields: nameFields)
        setCorners(fields: phoneNumFields)
        setCorners(fields: addressFields)
        uiLabel.layer.cornerRadius = 7
        
        updateStatesFieldText(with: State.allCases.first!)
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        stateField.inputView = pickerView
        
        for (index, element) in addressFields.enumerated() {
            print(element.placeholder as Any, index)
        }

    }
    
    // MARK: - IBActions
    
    /**
     // TODO: - Connect `IBAction`s here
     -
     
     */
    @IBAction func setEmergency(_ sender: UISwitch) {
        //get the contact unique id?
        //place a * icon in the tableView Contacts
    }
    
    func setup(model: ContactDetailModel, delegate: ContactDetailViewControllerDelegate) {
        /**
         // TODO: - Perform any setup prior to loading the view here
         -
         // HINT: -
         -
         - This function is already called in `ContactsListViewController.swift` within
         prepare(for segue:,sender:). Look there to see what work has been done for you.
         */
    }
    
    // MARK: - Methods
    
    /**
     // TODO: - If you have any methods, write them here
     -
     */
    
    func updateStatesFieldText(with state: State) {
        stateField.text = state.postalAbbreviation
    }
}

// MARK: - ContactDetailModelDelegate

/**
 // Conform `ContactDetailViewController` to the `ContactDetailModelDelegate` protocol here
 -
 */
 
let contactDM = ContactDetailModelDelegate.self

extension ContactDetailViewController: ContactDetailModelDelegate {
    func save(isEnabled: Bool) {
        
    }
}

/**
 // TODO: - Conform `ContactDetailViewController` to any additional protocols here
 -
 // HINT: - If this ViewController manages `UITextField` objects, it will need to adopt the `UITextFieldDelegate` protocol
 -
 */

extension ContactDetailViewController: UITextFieldDelegate {
    
}

extension ContactDetailViewController: UITableViewDelegate {

}

extension ContactDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateStatesFieldText(with: State.allCases[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return State.allCases[row].rawValue
    }

}

extension ContactDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return State.allCases.count
    }
    
}

class TextFieldPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

class LabelWithPadding: UILabel {
    var labelPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: labelPadding))
    }
}

func setCorners(fields: [UITextField]) {
    let last = fields.count - 1
    
    fields[0].layer.cornerRadius = 7
    fields[0].clipsToBounds = true
    fields[0].layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    fields[last].layer.cornerRadius = 7
    fields[last].clipsToBounds = true
    fields[last].layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
}
