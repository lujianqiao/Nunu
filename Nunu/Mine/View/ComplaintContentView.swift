//
//  ComplaintView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/3.
//

import UIKit

class ComplaintContentView: UIView {
    
    @IBOutlet weak var ploLab: UILabel!
    
    @IBOutlet weak var textV: UITextView!
    
    @IBOutlet weak var CONFIRM: UIButton!
    static func view() -> ComplaintContentView {
        let view = Bundle.main.loadNibNamed(String(describing: ComplaintContentView.self), owner: nil, options: nil)?.first as! ComplaintContentView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textV.contentInset = UIEdgeInsets(top: 3, left: 6, bottom: 10, right: 10)
        CONFIRM.layer.cornerRadius = 10
        textV.delegate = self
    }
    
}

extension ComplaintContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        ploLab.isHidden = textView.text.count > 0
    }
}
