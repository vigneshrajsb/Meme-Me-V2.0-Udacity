//
//  MemeViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/14/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

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
    var memeToEdit: Meme?
    let picker = UIPickerView()
    
    var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Impact", size: 30.0),
                                                     NSAttributedString.Key.foregroundColor: UIColor.white,
                                                     NSAttributedString.Key.strokeColor: UIColor.black,
                                                     NSAttributedString.Key.strokeWidth: -1.0]
    
    let fonts = ["IMPACT","HELVETICA","FUTURA","AVENIRNEXT"]
    let colors = ["WHITE","BLACK","BLUE","RED","YELLOW","GRAY"]
    
    var selectedFont: String = "IMPACT"
    var selectedColor: String = "WHITE"
    var selectedStrokeColor: String = "BLACK"
    
    var sizeForTopTextView: CGFloat = 30
    var sizeForBottomTextView: CGFloat = 30
    
    var sizeForMemeView: CGFloat = 0
    var sizeForPopUp: CGFloat = 0
    var viewFrameOriginY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    func initUI() {
        setupNavBar()
        setLayout()
      
        self.tabBarController?.tabBar.isHidden = true
        topTextView.delegate = self
        bottomTextView.delegate = self
        if let memeToEdit = memeToEdit {
            memeImageView.image = memeToEdit.image
            topTextView.text = memeToEdit.topText
            bottomTextView.text = memeToEdit.bottomText
        } else {
            memeImageView.image = selectedImage
            topTextView.attributedText = NSMutableAttributedString(string: defaultValueForTextView, attributes: attributes)
            bottomTextView.attributedText = NSMutableAttributedString(string: defaultValueForTextView, attributes: attributes)
        }
      setTextViewAttributes()
        
        fontTextField.delegate = self
        colorTextField.delegate = self
        strokeColorTextField.delegate = self
        
        if let selectedImage = selectedImage {
            memeImageView.image = selectedImage
        }
       
   
            setupTextFieldsForPopUp()
        setupObserversForKeyboard()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupObserversForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    
    
    @objc func keyBoardWillShow(notification: NSNotification) {
      print("Keyboard will show")
        
        if view.frame.origin.y >= 0 {
        /////////////
        viewFrameOriginY = view.frame.origin.y
        /////////
        if bottomTextView.isFirstResponder {
        print("View origin - \(self.view.frame.origin.y), \(viewFrameOriginY)")
        view.frame.origin.y = view.frame.origin.y - getKeyboardHeight(for: notification)
        }
        }
    }
    
    func getKeyboardHeight(for notification: NSNotification) -> CGFloat {
        
      guard let keyboardBeginFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return 0 }
        guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return 0 }
        print("Keyboard begin Frame - \(keyboardBeginFrame.cgRectValue.height) ---- Keyboard end Frame - \(keyboardEndFrame.cgRectValue.height)")
        
        return keyboardBeginFrame.cgRectValue.height
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        print("Keyboard will hide")
        view.frame.origin.y = viewFrameOriginY
            print("View origin - \(self.view.frame.origin.y), \(viewFrameOriginY)")
    }
    
    func setLayout() {
        if UIDevice.current.orientation.isPortrait {
            sizeForMemeView = view.safeAreaLayoutGuide.layoutFrame.width
             sizeForPopUp = sizeForMemeView - sizeForMemeView/9
        } else if UIDevice.current.orientation.isLandscape {
            sizeForMemeView = view.safeAreaLayoutGuide.layoutFrame.height
             sizeForPopUp = sizeForMemeView - sizeForMemeView/16
        }
        constraintMemeWidth.constant = sizeForMemeView
        constraintMemeHeight.constant = sizeForMemeView
        constraintPopUpWidth.constant = sizeForPopUp
        constraintPopUpHeight.constant = sizeForPopUp
    }
    
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    

    
    func setTextViewAttributes() {
        sizeForTopTextView = getSizeFor(length: topTextView.attributedText.length)
        let topAttributed =  NSMutableAttributedString(string: topTextView.text, attributes: attributes)
        topAttributed.addAttribute(NSAttributedString.Key.font, value: getFontFromString(string: selectedFont).withSize(sizeForTopTextView), range: NSRange(location: 0, length: topAttributed.length))
        topTextView.attributedText = topAttributed
        topTextView.textAlignment = .center
        
        sizeForTopTextView = getSizeFor(length: bottomTextView.attributedText.length)
        let bottomAttributed = NSMutableAttributedString(string: bottomTextView.text, attributes: attributes)
        bottomAttributed.addAttribute(NSAttributedString.Key.font
            , value: getFontFromString(string: selectedFont).withSize(sizeForBottomTextView), range: NSRange(location: 0, length: bottomAttributed.length))
        bottomTextView.attributedText = bottomAttributed
        bottomTextView.textAlignment = .center
        
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

    @objc func shareTapped() {
        print("share tapped")
         view.endEditing(true)
        let imageToShare = generateMemeImage() 
        
        let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        activityVC.completionWithItemsHandler = { (activityChosen, completed, items, error) in
            if completed {
                self.saveMeme()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        present(activityVC, animated: true, completion: nil)
        
    }
    
    func generateMemeImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: memeView.bounds)
        let image = renderer.image { (imageRendererContext) in
            memeView.layer.render(in: imageRendererContext.cgContext)
        }
        return image
        }
    
    func saveMeme() {
        print("Save Meme")
        guard let image = memeImageView.image else { return }
        
        let meme = Meme(image: image, topText: topTextView.text, bottomText: bottomTextView.text, dateSaved: Date(), memedImage: generateMemeImage())
        
        savedMemes.append(meme)
        print(savedMemes.count)
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
        print("done tapped")
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
    

}

extension MemeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
       
        if let textString = textView.text {

              if textString.count > maxCharactersAllowedForMemeText && text != "" {
                textView.shake()
             return false
            }
        }
       
        let existingText = textView.text as NSString
        let updatedText =  existingText.replacingCharacters(in: range, with: text)

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
    
    func getSizeFor(length: Int) -> CGFloat {
        var size: CGFloat = 0
        switch length {
        case 0...25:
            size = 30
        case 26...50:
            size = 26
        case 41...70:
            size = 22
        default:
            size = 22
        }
        return size
    }
    
    
    func getAttributedFontWith(size: CGFloat, textFieldIdentifier: String) {
        if textFieldIdentifier == "top" {
            topTextView.font = topTextView.font?.withSize(sizeForTopTextView)
        } else if textFieldIdentifier == "bottom" {
            bottomTextView.font = bottomTextView.font?.withSize(sizeForBottomTextView)
        }
    }

}


extension MemeViewController: UITextFieldDelegate {
    
    func setupTextFieldsForPopUp() {
        
        sampleLabel.attributedText = NSAttributedString(string: "SAMPLE TEXT", attributes: attributes)
        
      
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
        
        fontTextField.attributedText = NSAttributedString(string: selectedFont)
        colorTextField.attributedText = NSAttributedString(string: selectedColor)
        strokeColorTextField.attributedText = NSAttributedString(string: selectedStrokeColor)
    }
    
    @objc func accessoryDoneTapped() {
        view.endEditing(true)
    }
    
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
    
    func enableOnlyCurrentTextField() {
        fontTextField.isEnabled = fontTextField.isFirstResponder ? true : false
        colorTextField.isEnabled = colorTextField.isFirstResponder ? true : false
        strokeColorTextField.isEnabled = strokeColorTextField.isFirstResponder ? true : false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fontTextField.isEnabled =  true
        colorTextField.isEnabled = true
        strokeColorTextField.isEnabled =  true
    }
 
}

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
        print(index)
        updateTextAttributes(for:index)
    }
    
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
        
       sampleLabel.attributedText = NSAttributedString(string: sampleLabel.text ?? "SAMPLE TEXT", attributes: attributes)
        
    }

    
}
