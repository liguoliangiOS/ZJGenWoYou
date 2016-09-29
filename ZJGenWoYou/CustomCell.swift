//
//  CustomCell.swift
//  ZJGenWoYou
//
//  Created by 李国良 on 2016/9/27.
//  Copyright © 2016年 李国良. All rights reserved.
//

import UIKit

private let  KLMargin:CGFloat  = 10
private let  imgSize:CGFloat = 60
private let  titleWidth:CGFloat = UIScreen .mainScreen().bounds.width - 3.0*KLMargin - imgSize

class CustomCell: UITableViewCell {
    var customView    : UIView!
    var titleLabel    : UILabel!
    var headImageView : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:reuseIdentifier)
       
       setupView()
    }
    
    func setupView() {
        
        customView = UIView(frame: CGRectMake(0, 0, 80, 80))
        self.contentView.addSubview(customView)
        // 头像img
        headImageView = UIImageView(frame: CGRectMake(KLMargin, KLMargin, imgSize, imgSize))
        customView.addSubview(headImageView)
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxY(headImageView.frame) + KLMargin, KLMargin, titleWidth, imgSize))
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.numberOfLines = 0
        customView.addSubview(titleLabel)
    }
    
    class func cellHeight() -> CGFloat {
        return 80;
    }
    // 根据model 填充Cell
    func cellForModel(model: TextModel?){
        if let tempModel = model {
            titleLabel.text = tempModel.name
            headImageView.image = UIImage(named: tempModel.headImage);
        }
    }
    
    class func customeCellWithTabbleView(tableView: UITableView?) -> CustomCell {
        let customIdentifier = "customCell"
        var cell = tableView?.dequeueReusableCellWithIdentifier(customIdentifier) as? CustomCell
        if cell == nil {
            cell = CustomCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: customIdentifier)
        }
        return cell!
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
