//
//  MemeViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/14/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import Realm
import  RealmSwift

class MemeViewController: UIViewController {
    
    let defaultValueForTextView: String = "ENTER TEXT"
    
    @IBOutlet weak var constraintHeightForBottomTextView: NSLayoutConstraint!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomTextView: UITextView!
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var fontTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var strokeColorTextField: UITextField!
    
    @IBOutlet weak var constraintMemeHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintMemeWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintPopUpHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintPopUpWidth: NSLayoutConstraint!
    
    var cancelButton: UIBarButtonItem!
    var optionsButton: UIBarButtonItem!
    var shareButton: UIBarButtonItem!
    
    var selectedImage: UIImage?
     var memeToEdit: MemeMe?
    let picker = UIPickerView()
    
    //Default attributes set
    var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 30.0),
                                                     NSAttributedString.Key.foregroundColor: UIColor.white,
                                                     NSAttributedString.Key.strokeColor: UIColor.black,
                                                     NSAttributedString.Key.strokeWidth: -1.0]
    //Creating the list of fonts and colors as an array
    let fonts = ["IMPACT","HELVETICA","FUTURA","AVENIRNEXT"]
    let colors = ["WHITE","BLACK","BLUE","RED","YELLOW","GRAY"]
    
    //Setting up default values
    var selectedFont: String = "IMPACT"
    var selectedColor: String = "WHITE"
    var selectedStrokeColor: String = "BLACK"
    
    var sizeForTopTextView: CGFloat = 30
    var sizeForBottomTextView: CGFloat = 30
    
    var sizeForMemeView: CGFloat = 0
    var sizeForPopUp: CGFloat = 0
    var viewFrameOriginY: CGFloat = 0
    
    //MARK:- View methods override
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        selectedImage = nil
        memeToEdit = nil
    }
    
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    
    //MARK: - UI setup and updates
    func initUI() {
        setupNavBar()
        self.tabBarController?.tabBar.isHidden = true
        setLayout()
        //Setting up Aspect Fit for the image in Meme
        memeImageView.contentMode = .scaleAspectFit
        
        if let memeToEdit = memeToEdit {
            memeImageView.image = UIImage(data: memeToEdit.image)
            topTextView.text = memeToEdit.topText
            bottomTextView.text = memeToEdit.bottomText
            selectedFont = memeToEdit.font
            selectedColor = memeToEdit.color
            selectedStrokeColor = memeToEdit.border
        } else if (selectedImage != nil){
            memeImageView.image = selectedImage
            topTextView.attributedText = NSMutableAttributedString(string: defaultValueForTextView, attributes: attributes)
            bottomTextView.attributedText = NSMutableAttributedString(string: defaultValueForTextView, attributes: attributes)
        } else {
            Alerts.showCustomAlertAndDismissMemeEditor(on: self, title: "Error", message: "Something went wrong. Please try again!", actionTitle: "Try Again")
        }
        setTextViewAttributes()
        setupTextFieldsForPopUp()
        setupObserversForKeyboard()
    }
    
    func setupNavBar() {
        cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelTapped))
        optionsButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(optionsTapped))
        shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action , target: self, action: #selector(shareTapped))
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItems = [cancelButton, optionsButton]
        self.navigationItem.leftBarButtonItem = shareButton
        cancelButton.title = "Cancel"
        cancelButton.tintColor = customYellow
        optionsButton.image = UIImage(named: "settings")
    }
    
    //MARK: - For Pop up
    func enableOnlyCurrentTextField() {
        fontTextField.isEnabled = fontTextField.isFirstResponder ? true : false
        colorTextField.isEnabled = colorTextField.isFirstResponder ? true : false
        strokeColorTextField.isEnabled = strokeColorTextField.isFirstResponder ? true : false
    }
    
    func setupTextFieldsForPopUp() {
        sampleLabel.attributedText = NSAttributedString(string: sampleText, attributes: attributes)
        
        //setup the input  and input accessory view
        picker.delegate = self
        picker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 160)
        fontTextField.inputView = picker
        colorTextField.inputView = picker
        strokeColorTextField.inputView = picker
        
        let accessoryBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        fontTextField.inputAccessoryView = accessoryBar
        colorTextField.inputAccessoryView = accessoryBar
        strokeColorTextField.inputAccessoryView = accessoryBar
        
        let accessoryButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(accessoryDoneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        accessoryBar.setItems([flexibleSpace,accessoryButton], animated: true)
        
        //Display the values selected in the Text Fields
        fontTextField.attributedText = NSAttributedString(string: selectedFont)
        colorTextField.attributedText = NSAttributedString(string: selectedColor)
        strokeColorTextField.attributedText = NSAttributedString(string: selectedStrokeColor)
    }
    
    @objc func accessoryDoneTapped() {
        view.endEditing(true)
    }

    //MARK: - Keyboard Methods
    func setupObserversForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func getKeyboardHeight(for notification: NSNotification) -> CGFloat {
        //get the keyBoard frame and return the height to caller
        guard let keyboardBeginFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return 0 }
        return keyboardBeginFrame.cgRectValue.height
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        //checking to see if the view origin is already moved up, if not move the origin with the keyboard height
        if view.frame.origin.y >= 0 {
            viewFrameOriginY = view.frame.origin.y
            if bottomTextView.isFirstResponder {
                view.frame.origin.y = view.frame.origin.y - getKeyboardHeight(for: notification)
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        //restore the view origin back to what it was
        view.frame.origin.y = viewFrameOriginY
    }
    
    //MARK: - Set MemeMe & Pop up size
    func setLayout() {
        let sizeIfiPad : CGFloat = 350.0
        if UIDevice.current.orientation.isLandscape {
            sizeForMemeView = view.safeAreaLayoutGuide.layoutFrame.height
             sizeForPopUp = sizeForMemeView - sizeForMemeView/16
        } else {
                sizeForMemeView = view.safeAreaLayoutGuide.layoutFrame.width
                sizeForPopUp = sizeForMemeView - sizeForMemeView/9
        }
        constraintMemeWidth.constant = sizeForMemeView
        constraintMemeHeight.constant = sizeForMemeView
        constraintPopUpWidth.constant = UIDevice.current.userInterfaceIdiom == .pad ? sizeIfiPad : sizeForPopUp
        constraintPopUpHeight.constant = UIDevice.current.userInterfaceIdiom == .pad ? sizeIfiPad : sizeForPopUp
    }
    
    
    func setTextViewAttributes() {
        //determine the size of the text with the length - need when editing an existing meme
        sizeForTopTextView = getSizeFor(length: topTextView.attributedText.length)
        //update to existing attributes for existing memes and to default attributes on a new Meme
        updateTextAttributes(font: selectedFont, color: selectedColor, strokeColor: selectedStrokeColor)
        let topAttributed =  NSMutableAttributedString(string: topTextView.text, attributes: attributes)
        //adding the size attribute here to change from default on existing memes
        topAttributed.addAttribute(NSAttributedString.Key.font, value: getFontFromString(string: selectedFont).withSize(sizeForTopTextView), range: NSRange(location: 0, length: topAttributed.length))
        topTextView.attributedText = topAttributed
        topTextView.textAlignment = .center
        
        //repeat same for bottom text view
        sizeForBottomTextView = getSizeFor(length: bottomTextView.attributedText.length)
        let bottomAttributed = NSMutableAttributedString(string: bottomTextView.text, attributes: attributes)
        bottomAttributed.addAttribute(NSAttributedString.Key.font
            , value: getFontFromString(string: selectedFont).withSize(sizeForBottomTextView), range: NSRange(location: 0, length: bottomAttributed.length))
        bottomTextView.attributedText = bottomAttributed
        bottomTextView.textAlignment = .center
    }
    
    //MARK: - Update Text Attributes Methods
    func updateTextAttributes(for index: Int) {
        if fontTextField.isFirstResponder {
            selectedFont = fonts[index]
            fontTextField.text = selectedFont
            attributes[NSAttributedString.Key.font] = getFontFromString(string: selectedFont)
        } else if colorTextField.isFirstResponder {
            selectedColor = colors[index]
            colorTextField.text = selectedColor
            attributes[NSAttributedString.Key.foregroundColor] = getColorFromString(string: selectedColor)
        } else if strokeColorTextField.isFirstResponder {
            selectedStrokeColor = colors[index]
            strokeColorTextField.text = selectedStrokeColor
            attributes[NSAttributedString.Key.strokeColor] = getColorFromString(string: selectedStrokeColor)
        }
        sampleLabel.attributedText = NSAttributedString(string: sampleLabel.text ?? sampleText, attributes: attributes)
    }
    
    func updateTextAttributes(font: String, color: String, strokeColor: String) {
        attributes[NSAttributedString.Key.font] = getFontFromString(string: font)
        attributes[NSAttributedString.Key.foregroundColor] = getColorFromString(string: color)
        attributes[NSAttributedString.Key.strokeColor] = getColorFromString(string: strokeColor)
    }
    
    //Method to update the text size on update of TextView text
    func updateTextSize(forCharacters char: Int) {
        let size: CGFloat = getSizeFor(length: char)
        
        if bottomTextView.isFirstResponder {
            bottomTextView.font = bottomTextView.font?.withSize(size)
            sizeForBottomTextView = size
        } else {
            topTextView.font = topTextView.font?.withSize(size)
            sizeForTopTextView = size
        }
    }
    
    //Updating the font size for the attributed text as needed
    func getAttributedFontWith(size: CGFloat, textFieldIdentifier: String) {
        if textFieldIdentifier == "top" {
            topTextView.font = topTextView.font?.withSize(sizeForTopTextView)
        } else if textFieldIdentifier == "bottom" {
            bottomTextView.font = bottomTextView.font?.withSize(sizeForBottomTextView)
        }
    }

    //MARK: - Bar Button action methods
    @objc func shareTapped() {
         view.endEditing(true)
        let imageToShare = generateMemeImage()
        let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        activityVC.completionWithItemsHandler = { (activityChosen, completed, items, error) in
            if completed {
                self.saveMeme()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        //if ipad present in pop over presentation controller
        if UIDevice.current.userInterfaceIdiom == .pad {
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.minX , y: self.view.frame.minY , width: 100, height: 130)
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc func optionsTapped() {
         view.endEditing(true)
        constraintPopUpWidth.constant = 0
        constraintPopUpHeight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.5
            self.popUpView.alpha = 1.0
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItems?.first?.isEnabled = false
            self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
        }
    }
    
    @objc func cancelTapped() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        accessoryDoneTapped()
        UIView.animate(withDuration: 0.2) {
            self.setTextViewAttributes()
            self.backgroundView.alpha = 0
            self.popUpView.alpha = 0.0
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItems?.first?.isEnabled = true
            self.navigationItem.rightBarButtonItems?.last?.isEnabled = true
        }
    }
    
    //MARK: - Meme Creation and Save
    
    func generateMemeImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: memeView.bounds)
        let image = renderer.image { (imageRendererContext) in
            memeView.layer.render(in: imageRendererContext.cgContext)
        }
        return image
    }
    
    func saveMeme() {
        guard memeImageView.image != nil else { return }
        saveInRealm()
    }
    
    func saveInRealm() {
        guard let image = memeImageView.image?.jpegData(compressionQuality: 1) else { return }
        guard let memedImage = generateMemeImage().jpegData(compressionQuality: 1) else { return }
        let meme = MemeMe()
        meme.topText = topTextView.text
        meme.bottomText = bottomTextView.text
        meme.dateSaved = Date()
        meme.font = selectedFont
        meme.color = selectedColor
        meme.border = selectedStrokeColor
        meme.image = image
        meme.memedImage = memedImage
        
        do {
            let realm = try Realm()
        try realm.write {
            if let memeToEdit = memeToEdit{
              realm.delete(memeToEdit)
            }
            realm.add(meme)
    
        }
        } catch let error {
            Alerts.showCustomAlert(on: self, title: "Error", message: error.localizedDescription, actionTitle: "Okay")
        }
    }
}

//MARK: - Text View Delegate Methods
extension MemeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //if the user enters Return key, exit editing
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
       
        if let textString = textView.text {
            //if text length greater than the max allowed do not add characters and generate a taptic feedback to let the users know with an animation
              if textString.count > maxCharactersAllowedForMemeText && text != "" {
                let generator = UINotificationFeedbackGenerator()
                textView.shake()
                generator.notificationOccurred(.warning)
             return false
            }
        }
        //Capitalization did not work on devices even with Auto Caps enabled in storyboard, so updating to CAPS here
        let existingText = textView.text as NSString
        let updatedText =  existingText.replacingCharacters(in: range, with: text.capitalized)
        
        //Also updating to the attributes set while adding the replacement text
        let updateToAttributeText = NSMutableAttributedString(string: updatedText, attributes: attributes)
        textView.attributedText = updateToAttributeText
        updateTextSize(forCharacters: updateToAttributeText.length)
        textView.textAlignment = .center
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "ENTER TEXT" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "ENTER TEXT"
        }
    }
    
  
}

//MARK: - Text Field Delegate Methods
extension MemeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enableOnlyCurrentTextField()
        var index = 0
        if fontTextField.isFirstResponder {
        index = fonts.index { $0 == selectedFont } ?? 0
        } else if colorTextField.isFirstResponder  {
            index = colors.index { $0 == selectedColor} ?? 0
        } else if strokeColorTextField.isFirstResponder {
            index = colors.firstIndex(of: selectedStrokeColor) ?? 0
        }
        print(index)
       
        picker.selectRow(index, inComponent: 0, animated: true)
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fontTextField.isEnabled =  true
        colorTextField.isEnabled = true
        strokeColorTextField.isEnabled =  true
    }
 
}

//MARK: - Picker delegate methods
extension MemeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if fontTextField.isFirstResponder {
        return fonts.count
        } else {
            return colors.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if fontTextField.isFirstResponder {
            return fonts[row]
        } else {
            return colors[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let index = pickerView.selectedRow(inComponent: component)
        updateTextAttributes(for:index)
    }
    

}
