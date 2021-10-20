//
//  ViewController.swift
//  MyWebsites
//
//  Created by Michael Kazmerski on 10/20/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var webName: UITextField!
    @IBOutlet weak var descript: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    
    @IBAction func btnEdit(_ sender: UIButton) {
        webName.isEnabled = true
        descript.isEnabled = true
        url.isEnabled = true
        date.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        webName.becomeFirstResponder()
    }

    @IBAction func btnSave(_ sender: UIButton) {
        //1 Add Save Logic
                
                
                if (websitedb != nil)
                {
                    
                    websitedb.setValue(webName.text, forKey: "webname")
                    websitedb.setValue(descript.text, forKey: "descript")
                    websitedb.setValue(url.text, forKey: "url")
                    websitedb.setValue(date.text, forKey: "date")
                    
                }
                else
                {
                    let entityDescription =
                        NSEntityDescription.entity(forEntityName: "Website",in: managedObjectContext)
                    
                    let website = Website(entity: entityDescription!,
                                          insertInto: managedObjectContext)
                    
                    website.webName = webName.text!
                    website.descript = descript.text!
                    website.url = url.text!
                    website.date = date.text!
                }
                var error: NSError?
                do {
                    try managedObjectContext.save()
                } catch let error1 as NSError {
                    error = error1
                }
                
                if let err = error {
                    //if error occurs
                   // status.text = err.localizedFailureReason
                } else {
                    self.dismiss(animated: false, completion: nil)
                    
                }
    }
    
@IBAction func btnBack(_ sender: UIBarButtonItem)
    {    //2) Dismiss ViewController
           self.dismiss(animated: true, completion: nil)
    //       let detailVC = ContactTableViewController()
    //        detailVC.modalPresentationStyle = .fullScreen
    //        present(detailVC, animated: false)
    }
    
    //3) Add ManagedObject Data Context
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //4) Add variable contactdb (used from UITableView
        var websitedb:NSManagedObject!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (websitedb != nil)
        {
            webName.text = websitedb.value(forKey: "webNname") as? String
            descript.text = websitedb.value(forKey: "descript") as? String
            url.text = websitedb.value(forKey: "url") as? String
            date.text = websitedb.value(forKey: "date") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            webName.isEnabled = false
            descript.isEnabled = false
            url.isEnabled = false
            date.isEnabled = false
            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            btnEdit.isHidden = true
            webName.isEnabled = true
            descript.isEnabled = true
            url.isEnabled = true
            date.isEnabled = true
        }
        webName.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    //6 Add to hide keyboard
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches , with:event)
            if (touches.first as UITouch?) != nil {
                DismissKeyboard()
            }
        }
    //7 Add to hide keyboard
        
        @objc func DismissKeyboard(){
            //forces resign first responder and hides keyboard
            webName.endEditing(true)
            descript.endEditing(true)
            url.endEditing(true)
            date.endEditing(true)
        }
    //8 Add to hide keyboard
        
        func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
            textField.resignFirstResponder()
            return true;
        }
}

