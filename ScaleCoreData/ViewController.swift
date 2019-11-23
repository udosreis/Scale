//
//  ViewController.swift
//  Scale
//
//  Created by David & Isabelle on 1/20/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var animations: UISwitch!
    @IBOutlet weak var newtons: UISwitch!
    @IBOutlet weak var tutorial: UILabel!
    @IBOutlet weak var animationsTitle: UILabel!
    @IBOutlet weak var newtonsTitle: UILabel!
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var zeroLabel: UIButton!
    @IBOutlet weak var settingLabel: UIButton!
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var newtonSwitch: UISwitch!
    @IBOutlet weak var animationSwitch: UISwitch!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var chineseFlag: UIButton!
    @IBOutlet weak var frenchFlag: UIButton!
    @IBOutlet weak var spanishFlag: UIButton!
    @IBOutlet weak var englishFlag: UIButton!
    @IBOutlet weak var cantUseView: UIView!
    @IBOutlet weak var cantUseLabel: UITextView!
    @IBOutlet weak var aboutCreatorView: UIView!
    @IBOutlet weak var creatorImg: UIImageView!
    @IBOutlet weak var creatorText: UILabel!
    @IBOutlet weak var creatorLinkOne: UIButton!
    @IBOutlet weak var creatorBar: UIView!
    @IBOutlet weak var creatorLinkTwo: UIButton!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsText: UIButton!
    @IBOutlet weak var termsTextView: UIView!
    @IBOutlet weak var termsTextScroll: UITextView!
    var timer = Timer()
    var language = 0
    var zero = 0.0
    var roundGrams = 0.0
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let fontName = "Trebuchet MS"
    
    //Prefered Language
    let languagePreferred = Bundle.main.preferredLocalizations.first
    //Languages - Add zero
    var english = ["Weigh your items with a spoon", "grams", "newtons", "Settings", "Animations","Zero","Dear User,\nWe are sorry to announce this app will not work on your device as it is either not an iPhone 6 or higher, or it is not updated to iOS 9.0 or a more recent version.\nSorry for the inconvenience,\nUgo Corp"]
    var french = ["Pesez vos articles avec une cuillère", "grammes", "newtons" , "Réglage", "Animations","Zéro","Cher utilisateur,\nNous sommes désolés d'annoncer que cette application ne fonctionnera pas sur votre appareil car ce n'est pas un iPhone 6 ou supérieur, ou il n'est pas mis à jour vers iOS 9.0 ou une version plus récente.\nDésolé pour le dérangement,\nUgo Corp"]
    var spanish = ["Pesa tus objetos con una cuchara", "gramos", "newtons", "Ajustes", "Animaciones","Cero","Estimado usuario,\nLo sentimos de anunciar esta aplicación no funcionará en su dispositivo proque no es un iPhone 6 o superior, o no es actualizado a iOS 9.0 o una versión más reciente.\nLos sentimos por las molestias,\nUgo Corp"]
    var chinese = ["用勺子称重物品", "克", "牛顿", "设定", "动画","零"]
    
    override func viewDidAppear(_ animated: Bool) {
        //Sends msg if they can't use the app
        do {
            if #available(iOS 9.0, *), UIForceTouchCapability.available == traitCollection.forceTouchCapability {
                print("Can use")
                cantUseView.isHidden = true
                aboutCreatorView.frame = CGRect(x: width*0.02133, y: 20, width: width*0.9573, height: height*0.14993)
                termsView.frame = CGRect(x: width*0.02133, y: height*0.20417, width: width*0.9573, height: height*0.03748)
                termsTextView.frame = CGRect(x: width*0.02133, y: 20, width: width*0.9573, height: height*0.14993)
            }
            else {
                let cantUse = UIAlertController(title: "App Usage", message: english[6], preferredStyle: .actionSheet)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                cantUse.addAction(okButton)
                self.present(cantUse, animated: true, completion: nil)
                cantUseView.isHidden = false
                aboutCreatorView.frame = CGRect(x: width*0.02133, y: height*0.20417, width: width*0.9573, height: height*0.14993)
                termsView.frame = CGRect(x: width*0.02133, y: height*0.37435, width: width*0.9573, height: height*0.03748)
                termsTextView.frame = CGRect(x: width*0.02133, y: 20, width: width*0.9573, height: height*0.31234)
            }
            termsTextScroll.setContentOffset(CGPoint.zero, animated: false)
        }
        catch {
            print("Error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.isHidden = true
        weight.text = "0.0\ngrams"
        let widthSetting = width*0.654
        let heightSetting = height*0.23238
        var switchScale = height/667
        var flagSize = height*0.05997
        print(languagePreferred)
        //Get CoreData language
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        request.returnsObjectsAsFaults = false
        var languageNumber = 0
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                languageNumber = data.value(forKey: "languageNum") as! Int
            }
            if languageNumber == -1 {
                //Set first time language
                if languagePreferred == Optional("fr") {
                    french(self)
                }
                else if languagePreferred == Optional("es") {
                    spanish(self)
                }
                else if languagePreferred == Optional("zh") {
                    chinese(self)
                }
                else {
                    english(self)
                }
            }
            else {
                if languageNumber == 1 {
                    french(self)
                }
                else if languageNumber == 2 {
                    spanish(self)
                }
                else if languageNumber == 3 {
                    chinese(self)
                }
                else {
                    english(self)
                }
            }
        } catch {
            print("Failed")
        }
        //Fonts
        let titleFontSize = width * 0.1
        let textFontSize = width * 0.055
        let scaleFontSize = width * 0.15
        let gramFontSize = width * 0.085
        tutorial.font = UIFont(name: fontName, size: titleFontSize)
        scaleLabel.font = UIFont.systemFont(ofSize: scaleFontSize, weight: UIFont.Weight.ultraLight)
        weight.font = UIFont(name: fontName, size: gramFontSize)
        zeroLabel.titleLabel?.font = UIFont(name: fontName, size: textFontSize)
        settingLabel.titleLabel?.font = UIFont(name: fontName, size: textFontSize)
        animationsTitle.font = UIFont(name: fontName, size: textFontSize)
        newtonsTitle.font = UIFont(name: fontName, size: textFontSize)
        companyLabel.font = UIFont(name: fontName, size: textFontSize)
        cantUseLabel.font = UIFont(name: fontName, size: textFontSize*0.75)
        creatorText.font = UIFont(name: fontName, size: textFontSize*0.75)
        termsText.titleLabel?.font = UIFont(name: fontName, size: textFontSize*0.7)
        termsTextScroll.font = UIFont(name: fontName, size: textFontSize*0.75)
        
        if (width==375 && height==812) {
            //IPHONE X
            companyLabel.isHidden = true
            switchScale = 1.0
            flagSize = 40
            scaleLabel.font = UIFont.systemFont(ofSize: scaleFontSize*1.12, weight: UIFont.Weight.ultraLight)
            newtonsTitle.font = UIFont(name: fontName, size: textFontSize*1.25)
            animationsTitle.font = UIFont(name: fontName, size: textFontSize*1.25)
            //Layout Adjustments - Main Page
            blurView.frame = CGRect(x: 0, y: 34, width: width, height: height*0.7106)
            circleImage.frame = CGRect(x: (width-height*0.4847)/2, y: height*0.21965+24, width: height*0.4847, height: height*0.4847)
            tutorial.frame = CGRect(x: 5, y: height*0.02999+24, width: width-10, height: height*0.1769)
            scaleLabel.frame = CGRect(x: 0, y: height*0.4028+24, width: width, height: height*0.1184)
            weight.frame = CGRect(x: width*0.272, y: height*0.7496+24, width: width*0.4533, height: height*0.1509) //Fix
            settingLabel.frame = CGRect(x: width*0.662, y: height*0.7496+24, width: width*0.338, height: height*0.0945)
            zeroLabel.frame = CGRect(x: 0, y: height*0.7496+24, width: width*0.338, height: height*0.0945)
            //Layout Adjustments - Settings
            settingView.frame = CGRect(x: width*0.325, y: height*0.4643, width: widthSetting, height: heightSetting)
            newtonsTitle.frame = CGRect(x: widthSetting*0.0327, y: heightSetting*0.0963, width: width*0.4587, height: height*0.0315)
            animationsTitle.frame = CGRect(x: widthSetting*0.0327, y: heightSetting*0.385, width: width*0.4587, height: height*0.0315)
            newtonSwitch.transform = CGAffineTransform(scaleX: switchScale, y: switchScale)
            animationSwitch.transform = CGAffineTransform(scaleX: switchScale, y: switchScale)
            newtonSwitch.frame = CGRect(x: widthSetting*0.767, y: heightSetting*0.0963, width: width*0.2, height: height*0.0315)
            animationSwitch.frame = CGRect(x: widthSetting*0.767, y: heightSetting*0.385, width: width*0.2, height: height*0.0315)
            frenchFlag.frame = CGRect(x: widthSetting*0.41224, y: heightSetting*0.67096+10, width: flagSize, height: flagSize)
            englishFlag.frame = CGRect(x: widthSetting*0.21632, y: heightSetting*0.67096+10, width: flagSize, height: flagSize)
            spanishFlag.frame = CGRect(x: widthSetting*0.60816, y: heightSetting*0.67096+10, width: flagSize, height: flagSize)
            chineseFlag.frame = CGRect(x: widthSetting*0.80408, y: heightSetting*0.67096+10, width: flagSize, height: flagSize)
            creatorImg.frame = CGRect(x: width*0.021333, y: (height*0.14993-width*(0.25866-0.02133*2))/2, width: width*(0.25866-0.02133*2), height: width*(0.25866-0.02133*2))
            creatorImg.layer.cornerRadius = creatorImg.frame.size.width/2
            creatorImg.clipsToBounds = true
            creatorLinkOne.frame = CGRect(x: width*0.82126, y: height*0.02699, width: height*0.044978, height: height*0.044978)
            creatorLinkTwo.frame = CGRect(x: width*0.8153, y: height*0.07346, width: height*0.05097, height: height*0.05097)
            creatorText.frame = CGRect(x: width*0.25866, y: height*0.01499, width: width*0.496, height: height*0.1214)
            creatorBar.frame = CGRect(x: width*0.76267, y: height*0.01499, width: 3, height: height*0.1214)
        }
        else {
            //Other Device
            companyLabel.isHidden = false
            //Layout Adjustments - Main Page
            blurView.frame = CGRect(x: 0, y: 20, width: width, height: height*0.7106)
            circleImage.frame = CGRect(x: (width-height*0.5247)/2, y: height*0.19889, width: height*0.5247, height: height*0.5247)
            tutorial.frame = CGRect(x: 5, y: height*0.02999, width: width-10, height: height*0.1769)
            scaleLabel.frame = CGRect(x: 0, y: height*0.4028, width: width, height: height*0.1184)
            weight.frame = CGRect(x: width*0.272, y: height*0.7496, width: width*0.4533, height: height*0.1509)
            settingLabel.frame = CGRect(x: width*0.662, y: height*0.7496, width: width*0.338, height: height*0.0945)
            zeroLabel.frame = CGRect(x: 0, y: height*0.7496, width: width*0.338, height: height*0.0945)
            //Layout Adjustments - Settings
            settingView.frame = CGRect(x: width*0.325, y: height*0.4643, width: widthSetting, height: heightSetting)
            newtonsTitle.frame = CGRect(x: widthSetting*0.0327, y: heightSetting*0.0963, width: width*0.4587, height: height*0.0315)
            animationsTitle.frame = CGRect(x: widthSetting*0.0327, y: heightSetting*0.385, width: width*0.4587, height: height*0.0315)
            newtonSwitch.transform = CGAffineTransform(scaleX: switchScale, y: switchScale)
            animationSwitch.transform = CGAffineTransform(scaleX: switchScale, y: switchScale)
            newtonSwitch.frame = CGRect(x: widthSetting*0.767, y: heightSetting*0.0963, width: width*0.2, height: height*0.0315)
            animationSwitch.frame = CGRect(x: widthSetting*0.767, y: heightSetting*0.385, width: width*0.2, height: height*0.0315)
            frenchFlag.frame = CGRect(x: widthSetting*0.41224, y: heightSetting*0.67096, width: flagSize, height: flagSize)
            englishFlag.frame = CGRect(x: widthSetting*0.21632, y: heightSetting*0.67096, width: flagSize, height: flagSize)
            spanishFlag.frame = CGRect(x: widthSetting*0.60816, y: heightSetting*0.67096, width: flagSize, height: flagSize)
            chineseFlag.frame = CGRect(x: widthSetting*0.80408, y: heightSetting*0.67096, width: flagSize, height: flagSize)
            cantUseView.frame = CGRect(x: width*0.02133, y: 20, width: width*0.9573, height: height*0.14993)
            cantUseLabel.setContentOffset(CGPoint.zero, animated: false)
            creatorImg.frame = CGRect(x: width*0.021333, y: (height*0.14993-width*(0.25866-0.02133*2))/2, width: width*(0.25866-0.02133*2), height: width*(0.25866-0.02133*2))
            creatorImg.layer.cornerRadius = creatorImg.frame.size.width/2
            creatorImg.clipsToBounds = true
            creatorLinkOne.frame = CGRect(x: width*0.82126, y: height*0.02699, width: height*0.044978, height: height*0.044978)
            creatorLinkTwo.frame = CGRect(x: width*0.8153, y: height*0.07346, width: height*0.05097, height: height*0.05097)
            creatorText.frame = CGRect(x: width*0.25866, y: height*0.01499, width: width*0.496, height: height*0.1214)
            creatorBar.frame = CGRect(x: width*0.76267, y: height*0.01499, width: 3, height: height*0.1214)
        }
        timer = Timer.scheduledTimer(timeInterval: 16, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Animations
    @objc func UpdateTimer() {
        if (animations.isOn) {
            UIView.animate(withDuration: 16, animations: {
                self.image.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)})
            UIView.animate(withDuration: 16, animations: {
                self.image.transform = CGAffineTransform(rotationAngle: 0 / 180.0)})
        }
    }
    //Getting the Grams
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            //Checks for iOS version
            if #available(iOS 9.0, *) {
                //Checks if the phone has 3D touch
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if touch.force >= touch.maximumPossibleForce {
                        //If touch is at its max it wil say more than max
                        if (newtons.isOn) {
                            weight.text = String(Double(Int(Double(385/1000)*9.8*100.0)) / 100.0)
                            languageSet()
                        }
                        else {
                            weight.text = "385+\n"
                            languageSet()
                        }
                    } else {
                        //Calculate grams or newtons
                        let force = touch.force/touch.maximumPossibleForce
                        let grams = Double(force * 385) - zero
                        roundGrams = Double(Int(grams*10))/10.0
                        if (newtons.isOn) {
                            weight.text = String(Double(Int(Double(roundGrams/1000)*9.8*100.0)) / 100.0)
                            languageSet()
                        }
                        else {
                            weight.text = "\(roundGrams)\n"
                            languageSet()
                        }
                    }
                }
            }
        }
    }
    //Resetting grams
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        weight.text = "0.0\n"
        zero = 0
        roundGrams = 0.0
        languageSet()
    }
    //Settings
    @IBAction func settings(_ sender: UIButton) {
        if (blurView.isHidden) {
            blurView.alpha = 0
            blurView.isHidden = false
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
                self.blurView.alpha = 1
            })
        }
        else {
            UIView.animate(withDuration: 0.15, animations: {
                self.blurView.alpha = 0
            }, completion: { (finished: Bool) in
                if finished {
                    self.blurView.isHidden = true
                    self.blurView.alpha = 1
                    self.termsTextView.isHidden = true
                    self.termsTextView.alpha = 1
                }
            })
        }
        weight.text = "0.0\n"
        languageSet()
    }
    
    //Languages
    //Change language
    @IBAction func english(_ sender: Any) {
        language = 0
        tutorial.text = english[0]
        animationsTitle.text = english[4]
        settingLabel.setTitle(english[3], for: .normal)
        newtonsTitle.text = "Newtons"
        zeroLabel.setTitle(english[5], for: .normal)
        weight.text = "0.0\n"
        languageSet()
    }
    @IBAction func french(_ sender: Any) {
        language = 1
        tutorial.text = french[0]
        animationsTitle.text = french[4]
        settingLabel.setTitle(french[3], for: .normal)
        newtonsTitle.text = "Newtons"
        zeroLabel.setTitle(french[5], for: .normal)
        weight.text = "0.0\n"
        languageSet()
    }
    @IBAction func spanish(_ sender: Any) {
        language = 2
        tutorial.text = spanish[0]
        animationsTitle.text = spanish[4]
        settingLabel.setTitle(spanish[3], for: .normal)
        newtonsTitle.text = "Newtons"
        zeroLabel.setTitle(spanish[5], for: .normal)
        weight.text = "0.0\n"
        languageSet()
    }
    @IBAction func chinese(_ sender: Any) {
        language = 3
        tutorial.text = chinese[0]
        animationsTitle.text = chinese[4]
        settingLabel.setTitle(chinese[3], for: .normal)
        newtonsTitle.text = chinese[2]
        zeroLabel.setTitle(chinese[5], for: .normal)
        weight.text = "0.0\n"
        languageSet()
    }
    //Change the grams or newtons to corresponding language
    func languageSet() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let lang = Language(context: context)
        if (newtons.isOn) {
            if language == 0 {
                weight.text = weight.text! + english[2]
                cantUseLabel.text = english[6]
                lang.languageNum = 0
            }
            else if language == 1 {
                weight.text = weight.text! + french[2]
                cantUseLabel.text = french[6]
                lang.languageNum = 1
            }
            else if language == 2 {
                weight.text = weight.text! + spanish[2]
                cantUseLabel.text = spanish[6]
                lang.languageNum = 2
            }
            else {
                weight.text = weight.text! + chinese[2]
                lang.languageNum = 3
            }
        }
        else {
            if language == 0 {
                weight.text = weight.text! + english[1]
                cantUseLabel.text = english[6]
                lang.languageNum = 0
            }
            else if language == 1 {
                weight.text = weight.text! + french[1]
                cantUseLabel.text = french[6]
                lang.languageNum = 1
            }
            else if language == 2 {
                weight.text = weight.text! + spanish[1]
                cantUseLabel.text = spanish[6]
                lang.languageNum = 2
            }
            else {
                weight.text = weight.text! + chinese[1]
                lang.languageNum = 3
            }
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("saved")
        print(language)
    }
    //Zero the scale
    @IBAction func zero(_ sender: UIButton) {
        zero = roundGrams
    }
    //Open creator links
    @IBAction func openFacebook(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/profile.php?id=100013293251277")! as URL)
    }
    @IBAction func openGithub(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: "http://www.github.com/udosreis")! as URL)
    }
    //Show/Hide Terms
    @IBAction func showHideTerms(_ sender: UIButton) {
        if (termsTextView.isHidden) {
            termsTextView.alpha = 0
            termsTextView.isHidden = false
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
                self.termsTextView.alpha = 1
            })
        }
        else {
            UIView.animate(withDuration: 0.15, animations: {
                self.termsTextView.alpha = 0
            }, completion: { (finished: Bool) in
                if finished {
                    self.termsTextView.alpha = 1
                    self.termsTextView.isHidden = true
                }
            })
        }
    }
    
}

