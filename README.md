![icon](./Contacts/Assets.xcassets/icon.imageset/icon.png)

![Xcode 11.3](./Contacts/Assets.xcassets/Xcode-11.3-blue.imageset/Xcode-11.3-blue.png)
![Swift 5.0](./Contacts/Assets.xcassets/Swift-5.0-orange.imageset/Swift-5.0-orange.png)

# Contacts
For this project; students will be tasked with creating a scaled-down version of the __Contacts__ app.
Much of the logic for the __ContactsList__ portion is already supplied.  
See `Contacts_Screenshots.pdf` for an example of what the basic interface should look like at various points.  
See `Contacts_Demo{1-3}.mov` for an example user experience.

### Objectives
* Utilize *UI components* such as `UIBarButtonItem`, `UISwitch`, `UIPickerView` and `UITextField`
* Build on concepts introduced in the previous project(s)

### Tasks
This project will require students to do several things:
* Build the necessary user interface elements in `ContactDetail.storyboard`
* __Connect__ those interface elements to `ContactDetailViewController.swift` as `IBAction`s and `IBOutlet`s as appropriate
* __Conform__ `ContactDetailViewController` to the `ContactDetailModelDelegate` protocol
* Finish/Add methods in `InputField.swift`, `ContactDetailModel.swift` and `ContactDetailViewController`

### Requirements
* Once on the __ContactDetail__ page; the user should be able to supply input for creating/editing a `Contact` object
* If user input for an attribute of a `Contact` object exists, it must satisfy the following criteria in order for a `Save` operation to be enabled:
    * `Contact.firstName`: Must be `>= 2` characters in length
    * `Contact.lastName`: Must be `>= 2` characters in length
    * `Contact.address`:
        * `Address.street`: Must be `>= 3` characters in length __AND__ contain only letters (`Aa-Zz`) and decimal digits (`0-9`)
        * `Address.apartment`: Must be `>= 1` character in length __AND__ contain only letters (`Aa-Zz`) and decimal digits (`0-9`)
        * `Address.city`: Must be `>= 3` characters in length __AND__ contain only letters (`Aa-Zz`)
        * `Address.state`: Must be a valid `State` case
        * `Address.zipcode`: Must be `5` characters in length __AND__ contain only decimal digits (`0-9`)
    * `Contact.phone`: Must be `>= 7` characters  in length __AND__ must be a valid `Int`
    * `Contact.email`: Must contain the `@` symbol
    * `Contact.isEmpty`: Must __NOT__ be `false`
* Selection of the `Address.state` attribute __MUST__ be implemented with a `UIPickerView`
    * `State.rawValue` __MUST__ be used for displaying `State` case values within the `UIPickerView`
    * `State.postalAbbreviation` __MUST__ be used for displaying a user's selected `State` on the __ContactDetail__ page
* User input for the `Contact.isEmergencyContact` attribute __MUST__ be handled via a `UISwitch`
* Saving a new/edited `Contact` object notifies the __ContactsList__
* A keyboard __MUST__ be dismissed if the user presses the __return__ key or taps the superview at any point while supplying input
* The appropriate __keyBoardType__ for a given `InputField` __MUST__ be utilized
* Autolayout for __iPhone Portrait Mode__ is required
* The criterion of __ALL__ `TODO` tasks outlined in the project template __MUST__ be satisfied
* __MVC__ is required; view logic should only be present in the ViewControllers, and likewise, business logic should be kept exclusively in the data-models

### Notes
* Places where code should be implemented are marked with `TODO` comments and will appear as warnings in the Issue navigator when building the project
* A __SwiftLint__ build script has been added for convenience
* This project will utilize some pre-packaged objects from our `ObjectLibrary` package:
    * `Contact`
    * `Address`
    * `InputField`
    * `State`

(`ctrl + cmd + click` or `alt + click` on an object in the project to see documentation)

### Submission
* Projects should run on a minimum of __Xcode 11.3__
* Projects should be free of compile-time errors and crashes (run-time errors)
* Projects should not have any compile-time warnings (in yellow)
* Unless added by the student completing the project; __All__ comments (the green stuff) __MUST__ be deleted before submission
* The following files/directories __MUST__ be deleted from the project directory before submission:
    * `README.md`
    * `Contacts_Screenshots.pdf`
    * `Demos/`
    * `.gitignore`
    * `.git/`
    * `.github/`

When ready to submit; the student should rename the directory containing their project to their __UMSL ssoid__ (e.g. 'gmhz7b').  
Then, *right-click* on that folder and select the option that should say ' __Compress "{ssoid_directory_name}"__ '. Finally, upload the resulting __zip__ file to __Canvas__.  
Students should take special care to ensure their projects are devoid of compile-time errors/warnings and run-time errors. Failure to do so will result in significant deductions.  
