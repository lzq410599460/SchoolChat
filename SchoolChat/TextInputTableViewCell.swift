//
//  TextInputTableViewCell.swift
//  SchoolChat
//
//  Created by ZL on 16/6/22.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor.init(white: 1, alpha: 0.5).CGColor
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height )
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

class TextInputTableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var TextField: UITextField!
    
 
        
    func config (text : String,  prompt:String)
    {
        TextField.attributedPlaceholder = NSAttributedString.init(string: prompt, attributes: [
            NSForegroundColorAttributeName:UIColor.init(white: 1, alpha: 0.5)])
        
        
        TextField.text = text
        TextField.placeholder = prompt
        
        TextField.accessibilityValue = text
        TextField.accessibilityLabel = prompt
    
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        TextField.useUnderline()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
