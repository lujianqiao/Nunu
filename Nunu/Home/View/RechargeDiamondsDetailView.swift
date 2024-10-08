//
//  RechargeDiamondsDetailView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/8.
//

import UIKit

class RechargeDiamondsDetailView: UIView {

    lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Recharge"
        lab.textColor = .white
        lab.font = .boldSystemFont(ofSize: 17)
        return lab
    }()
    
    lazy var quantityView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var quantityImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home_coins")
        return image
    }()
    
    lazy var quantityLab: UILabel = {
        let lab = UILabel()
        lab.text = "Diamond quantity"
        lab.textColor = .init(red: 117 / 255, green: 117 / 255, blue: 117 / 255, alpha: 1)
        lab.font = .systemFont(ofSize: 12)
        return lab
    }()
    
    lazy var quantityNumLab: UILabel = {
        let lab = UILabel()
        lab.text = "10000"
        lab.textColor = .white
        lab.font = .boldSystemFont(ofSize: 17)
        return lab
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "delete_x"), for: .normal)
        return btn
    }()
    
    
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(RechargeDiamondsDetailCell.self, forCellReuseIdentifier: String(describing: RechargeDiamondsDetailCell.self))
        return table
    }()
    
    lazy var RechargeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Recharge", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17)
        btn.backgroundColor = .init(red: 255 / 255, green: 69 / 255, blue: 157 / 255, alpha: 1)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Cancellation", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17)
        btn.backgroundColor = .init(red: 39 / 255, green: 42 / 255, blue: 52 / 255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.init(red: 255 / 255, green: 69 / 255, blue: 157 / 255, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(red: 29 / 225, green: 33 / 225, blue: 48 / 225, alpha: 1)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(27)
        }
        
        addSubview(quantityView)
        quantityView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.size.equalTo(CGSize(width: 167, height: 41))
        }
        
        quantityView.addSubview(quantityImage)
        quantityImage.snp.makeConstraints { make in
            make.left.equalTo(5.5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 33, height: 25))
        }
        
        quantityView.addSubview(quantityLab)
        quantityLab.snp.makeConstraints { make in
            make.left.equalTo(quantityImage.snp.right).offset(4.5)
            make.top.equalTo(6)
        }
        
        quantityView.addSubview(quantityNumLab)
        quantityNumLab.snp.makeConstraints { make in
            make.left.equalTo(quantityLab)
            make.top.equalTo(quantityLab.snp.bottom).offset(1.5)
        }
        
        addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }
        
        addSubview(RechargeBtn)
        RechargeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-140)
            make.size.equalTo(CGSize(width: 290, height: 60))
        }
        
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(RechargeBtn.snp.bottom).offset(26)
            make.size.equalTo(CGSize(width: 290, height: 60))
        }
        
        addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(quantityView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(17.5)
            make.right.equalTo(-17.5)
            make.bottom.equalTo(RechargeBtn.snp.top).offset(-27)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RechargeDiamondsDetailView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RechargeDiamondsDetailCell.self)) as? RechargeDiamondsDetailCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}


class RechargeDiamondsDetailCell : UITableViewCell {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.init(white: 1, alpha: 0.6).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    lazy var diamondsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home_coins")
        return image
    }()
    
    lazy var numLab: UILabel = {
        let lab = UILabel()
        lab.text = "1000"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 17)
        return lab
    }()
    
    lazy var valueLab: UILabel = {
        let lab = UILabel()
        lab.text = "$1.9"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 19)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(diamondsImage)
        diamondsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(23)
            make.size.equalTo(CGSize(width: 41, height: 31))
        }
        
        bgView.addSubview(numLab)
        numLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(diamondsImage.snp.right).offset(6.5)
        }
        
        bgView.addSubview(valueLab)
        valueLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(23)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
