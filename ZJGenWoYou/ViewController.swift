//
//  ViewController.swift
//  ZJGenWoYou
//
//  Created by 李国良 on 2016/9/27.
//  Copyright © 2016年 李国良. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomSliderViewDelegate {

    var tableView:UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageArray = ["01.jpg", "02.jpg", "03.jpg"]
        //let imageUrlArray = ["http://resource.ljjwnz.com/resource/1112424cd07c8cb90348d7b43bebcdb2", "http://resource.ljjwnz.com/resource/117b373bef522096c4cc347040e537f5", "http://resource.ljjwnz.com/resource/10df957c4ba5ef2e4d4fca431421326f"]
        
    ///  =========   轮播图调用该方法 =========
        let customView = CustomSliderView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 300), type: SliderViewSourceType.SourceTypeLocalSource, imageArray: imageArray, sliderTime: 3.0)
        customView.delegate = self
        self.view.addSubview(customView)
        setTable()
    }
// =================  --- CustomSliderViewDelegate -- ============================
    func clickCurrentImage(currentIndxe: Int) {
        print("222----%ld",currentIndxe)
    }
    
    func setTable() {
        self.tableView = UITableView(frame: CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height), style:.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // 重用cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomCell = CustomCell.customeCellWithTabbleView(tableView)
        cell.titleLabel.text = players.last;
        cell.headImageView.image = UIImage (named: players.first!)
        return cell
    }
   
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CustomCell.cellHeight()
    }
    
    //懒加载
    lazy var players:[String] = {
        var temporaryPlayers = [String]()
            temporaryPlayers.append("head_image.jpg")
            temporaryPlayers.append("就是不肯睡觉世界杯上看见 深刻理解错那算了是考虑的技能测试了")
        return temporaryPlayers
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

