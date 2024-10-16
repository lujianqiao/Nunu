//
//  LogInView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/4.
//

import UIKit

class LogInContentView: UIView {

    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var aggreBtn: UIButton!
    
//    @IBOutlet weak var registerBtn: UIButton!
    
    var loginBlock:(() -> Void)?
    var registerBlock:(() -> Void)?
    
    static func view() -> LogInContentView {
        let view = Bundle.main.loadNibNamed(String(describing: LogInContentView.self), owner: nil, options: nil)?.first as! LogInContentView
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        aggreBtn.titleLabel?.numberOfLines = 0
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        guard let block = loginBlock else {return}
        block()
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard let block = registerBlock else {return}
        block()
    }
    
}
