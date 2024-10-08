//
//  ComplaintViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/3.
//

import UIKit

class ComplaintViewController: UIViewController {

    lazy var contentView: ComplaintContentView = {
        let view = ComplaintContentView.view()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .main
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(LUConstant.DNavigationFullHeight() + 10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(350)
        }
        // Do any additional setup after loading the view.
    }

}
