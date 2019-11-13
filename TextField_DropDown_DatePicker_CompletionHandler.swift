//
//  TextField_DropDown_DatePicker_CompletionHandler.swift
//  Lieberverwalter
//
//  Created by Rahul Gupta on 13/11/19.
//  Copyright © 2019 appsDev. All rights reserved.
//

import UIKit
import DropDown

extension UITextField {
    func addDropDown(forDataSource data:[String], completion: @escaping(String)->Void) {
        let selectTypeDropDown = DropDown()
        selectTypeDropDown.textColor = UIColor.black
        selectTypeDropDown.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        selectTypeDropDown.width = self.frame.width
        selectTypeDropDown.cellHeight = 50
        selectTypeDropDown.direction = .any
        selectTypeDropDown.cornerRadius = 5
        selectTypeDropDown.anchorView = self
        selectTypeDropDown.bottomOffset = CGPoint(x: 0, y:(selectTypeDropDown.anchorView?.plainView.bounds.height)!)
        selectTypeDropDown.topOffset = CGPoint(x: 0, y:-(selectTypeDropDown.anchorView?.plainView.bounds.height)!)
        selectTypeDropDown.dataSource = data
        selectTypeDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.text = item
            self.resignFirstResponder()
            print("Selected item: \(item) at index: \(index)")
            completion(item)
        }
        selectTypeDropDown.show()
    }
    private func actionHandler(sender:UIDatePicker,action:((UIDatePicker) -> Void)? = nil) {
        struct __ { static var action :((UIDatePicker) -> Void)? }
        if action != nil { __.action = action }
        else { __.action?(sender) }
    }
    @objc private func triggerActionHandler(sender:UIDatePicker) {
        self.actionHandler(sender: sender)
    }
    func addDatePickere(forMode mode :UIDatePicker.Mode, ForAction action:@escaping (UIDatePicker) -> Void) {
       
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.backgroundColor = .white
            datePickerView.datePickerMode = mode
            
            if mode == .countDownTimer{
                let calendar = Calendar(identifier: .gregorian)
                let newDate = DateComponents(calendar: calendar, hour: 0, minute: 1).date!
                datePickerView.setDate(newDate, animated: true)
                
            }
            self.inputView = datePickerView
            self.actionHandler(sender:datePickerView, action: action)
            datePickerView.addTarget(self, action:#selector(self.triggerActionHandler(sender:)) , for: .valueChanged)
        
        
    }
}

class UseTextField: CustomiseViewController {
    
    @IBOutlet weak var class_text : UITextField!
    @IBOutlet weak var DOB_text : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func classAction(_ sender: Any) {
        DispatchQueue.main.async {[weak self] in
            self?.view.endEditing(true)
        }
        class_text.addDropDown(forDataSource: ["1","2","3","4"]) {(result) in
            print(result)
        }
    }
    
    @IBAction func DOBAction(_ sender: Any) {
        DispatchQueue.main.async {[weak self] in
            self?.view.endEditing(true)
        }
        DOB_text.addDatePickere(forMode: .date) { (date) in
            print(date)
        }
    }
}
