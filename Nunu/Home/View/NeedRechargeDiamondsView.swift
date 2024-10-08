//
//  NeedRechargeDiamondsView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/8.
//

import UIKit

class NeedRechargeDiamondsView: UIView {

    var deleteBlock: (() -> Void)?
    
    @IBOutlet weak var rechargeBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    static func view() -> NeedRechargeDiamondsView {
        let view = Bundle.main.loadNibNamed(String(describing: NeedRechargeDiamondsView.self), owner: nil, options: nil)?.first as! NeedRechargeDiamondsView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rechargeBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
    }

    @IBAction func deleteAction(_ sender: Any) {
        guard let block = deleteBlock else {return}
        block()
    }
    
    
}
