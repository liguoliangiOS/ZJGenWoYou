//
//  CustomSliderView.swift
//  ZJGenWoYou
//
//  Created by 李国良 on 2016/9/29.
//  Copyright © 2016年 李国良. All rights reserved.
//

import UIKit

// =====  代理方法 ===========
protocol CustomSliderViewDelegate {
   func clickCurrentImage(currentIndxe: Int)
}

public enum SliderViewSourceType {
    case SourceTypeLocalSource
    case SourceTypeUrlSource
}

class CustomSliderView: UIView {
    
    private var imagView : UIImageView!
    private var imageData : [String]!;
    private var  myTimer : NSTimer?
    private var currentPage : Int!
    private var totalNumber : Int!
    var pageControl : UIPageControl!
    var sourceType : SliderViewSourceType!
    var timeInterval : Double!
    var delegate : CustomSliderViewDelegate?
    
//========================================--- 开始--- ==================================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame:CGRect, type:SliderViewSourceType, imageArray:[String]!, sliderTime:Double!) {
        self.init(frame: frame)
        self.imageData = imageArray
        self.sourceType = type
        self.currentPage = 0
        totalNumber = imageArray?.count
        self.timeInterval = sliderTime
        
        self.imagView = UIImageView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.imagView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imagView.clipsToBounds = true
        self.addSubview(self.imagView)
        self.imagView.userInteractionEnabled = true;
        
        self.pageControl = UIPageControl.init()
        self.pageControl.numberOfPages = totalNumber
        let pageSize: CGSize! = self.pageControl.sizeForNumberOfPages(totalNumber)
        self.pageControl.frame = (CGRectMake(0, 0, pageSize.width, pageSize.height))
        self.pageControl.center = CGPointMake(self.center.x, frame.height - 8);
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor();
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor();
        self.addSubview(self.pageControl)
        
        if type == SliderViewSourceType.SourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else {
            //网络请求
            self.imagView.sd_setImageWithURL(NSURL(string: self.imageData![currentPage]),placeholderImage: UIImage(named:"3333.png"))
            
        }
        
        //添加滑动手势
        let fromLeftRecongnizer = UISwipeGestureRecognizer(target: self, action:#selector(CustomSliderView.handleSwipeFromLeft))
        fromLeftRecongnizer.direction = .Left
        self.imagView.addGestureRecognizer(fromLeftRecongnizer)
        let fromRightRecongnizer = UISwipeGestureRecognizer(target: self, action:#selector(CustomSliderView.handleSwipeFromRight))
        fromRightRecongnizer.direction = .Right
        self.imagView.addGestureRecognizer(fromLeftRecongnizer)
        
        
        let tapRecongnizer = UITapGestureRecognizer(target: self, action:#selector(CustomSliderView.tapImgView))
        self.imagView.addGestureRecognizer(tapRecongnizer)
        
        
        setUpTimer(self.timeInterval)
        
    }
    
    func handleSwipeFromLeft() {
        currentPage = currentPage - 1
        if currentPage < 0 {
            currentPage = (self.imageData?.count)! - 1
        }
        self.pageControl.currentPage = currentPage
        if sourceType == SliderViewSourceType.SourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else if (sourceType == SliderViewSourceType.SourceTypeUrlSource) {
            self.imagView.sd_setImageWithURL(NSURL(string: self.imageData![currentPage]),placeholderImage: UIImage(named:"3333.png"))
        }
        transTionWithsubtype(kCATransitionFromLeft)
    }
    
    func transTionWithsubtype(subtype: String) {
        let transition = CATransition.init();
        transition.type = "cube";
        transition.subtype = subtype;
        transition.duration = 1.5;
        transition.delegate = self;
        self.imagView.layer.addAnimation(transition, forKey: nil)
    }
    
    func handleSwipeFromRight() {
        currentPage = currentPage + 1
        if currentPage >= self.imageData?.count {
            currentPage = 0
        }
        self.pageControl.currentPage = currentPage
        if sourceType == SliderViewSourceType.SourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else if (sourceType == SliderViewSourceType.SourceTypeUrlSource) {
             self.imagView.sd_setImageWithURL(NSURL(string: self.imageData![currentPage]),placeholderImage: UIImage(named:"3333.png"))
        }
        transTionWithsubtype(kCATransitionFromRight)
    }
    
    private func setUpTimer(timeIntterval:Double) {
        self.myTimer = NSTimer.init(timeInterval: timeIntterval, target: self, selector: #selector(CustomSliderView.handleSwipeFromRight), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.myTimer!, forMode: NSDefaultRunLoopMode)
    }
    
    override func animationDidStart(anim: CAAnimation) {
        if (self.myTimer != nil) {
            self.myTimer?.invalidate()
        }
        self.imagView.userInteractionEnabled = false
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if self.timeInterval > 0 {
            setUpTimer(self.timeInterval)
        } else {
            setUpTimer(self.timeInterval)
        }
        self.imagView.userInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// =====================================  点击图片 =======================================
    func tapImgView() {
        self.delegate?.clickCurrentImage(currentPage)
    }
    
}
