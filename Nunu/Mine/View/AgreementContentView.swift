//
//  AgreementView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/3.
//

import UIKit

class AgreementContentView: UIView {

    var closeBlock:(() -> Void)?
    
    @IBOutlet weak var contentText: UITextView!
    
    static func view() -> AgreementContentView {
        let view = Bundle.main.loadNibNamed(String(describing: AgreementContentView.self), owner: nil, options: nil)?.first as! AgreementContentView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentText.isEditable = false
        
        

        contentText.isEditable = false
        contentText.text = """
1、 Special Reminder \n We would like to remind you (user) that before registering as a Nunu user, please carefully read this Nunu User Service Agreement (hereinafter referred to as the "Agreement") to ensure that you fully understand the terms of this Agreement. Please carefully read and choose to accept or reject this agreement. You can only become an official registered user of Nunu and enjoy various services of Nunu after agreeing and clicking to confirm the terms of this agreement and completing the registration process. Your registration, login, use, and other actions will be deemed as acceptance of this agreement, and you agree to be bound by the terms of this agreement. If you do not agree with this agreement or have any questions about the terms of this agreement, please immediately stop the Nunu user registration process and choose not to use the services of this website. This agreement stipulates the rights and obligations between Nunu and the user regarding the "Nunu" service (hereinafter referred to as the "Service"). 'User' refers to individuals or organizations who register, log in, and use this service. This agreement may be updated by * * at any time. Once the updated agreement terms are published, they will replace the original agreement terms without further notice. Users can check the latest version of the agreement terms in this APP. After modifying the terms of the agreement, if the user does not accept the modified terms, please immediately stop using the services provided by Nunu. The user's continued use of the services provided by Nunu will be deemed as acceptance of the modified agreement.\n 2. Service Content\n 2.1. The specific content of this service is provided by XX according to the actual situation, including but not limited to authorizing users to use their accounts for instant messaging, adding friends, joining groups, and posting messages. XX may make changes to the services it provides, and the content of the services provided by XX may change at any time; Users will receive notification from XX regarding service changes. 2.2. The services provided by XX are all free of charge. If additional paid service functions are added in the future, further notice will be given.
"""
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        if let block = closeBlock {
            block()
        }
    }
    
}
