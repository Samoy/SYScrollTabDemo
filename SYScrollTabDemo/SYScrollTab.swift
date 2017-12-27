//
//  SYScrollTab.swift
//  SYScrollTabDemo
//
//  Created by Samoy Young on 2017/12/27.
//  Copyright © 2017年 Samoy. All rights reserved.
//

import UIKit

typealias OnSelected = (Int,String?) -> Void


class SYScrollTab: UIView {
    let baseBtnTag = 100
    var titleArray:[String]?//标题数组
    var selectedTintColor:UIColor = #colorLiteral(red: 0.04705882353, green: 0.4156862745, blue: 0.7960784314, alpha: 1)//选中前景色
    var selectedBackgroundColor:UIColor = #colorLiteral(red: 0.8862745098, green: 0.9882352941, blue: 0.9843137255, alpha: 1)//选中背景色
    var normalTintColor:UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)//正常前景色
    var normalBackgroundColor:UIColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9764705882, alpha: 1)//正常背景色
    private var lastSelectedBtn:UIButton?
    private var scrollView:UIScrollView?
    var selctedIndex:Int = -1 {
        didSet{
            //默认选中
            if self.selctedIndex >= 0 {
                self.onClick(btn: self.scrollView?.viewWithTag(baseBtnTag + self.selctedIndex) as! UIButton)
            }
        }
    }
    var onSelected:OnSelected?
    
    convenience init(frame: CGRect,titleArray:[String]) {
        self.init(frame: frame)
        //添加滚动视图
        addScrollView()
        //添加按钮
        var x:CGFloat = 0//x坐标
        for i in 0 ..< titleArray.count {
            let btn = UIButton()
            btn.setTitle(titleArray[i], for: .normal)
            btn.tag = baseBtnTag + titleArray.index(of: titleArray[i])!
            btn.addTarget(self, action: #selector(onClick(btn:)), for: .touchUpInside)
            btn.backgroundColor = normalBackgroundColor
            btn.setTitleColor(normalTintColor, for: .normal)
            btn.layer.cornerRadius = frame.size.height/2
            //button宽度自适应
            var titleSize = titleArray[i].size(withAttributes: [NSAttributedStringKey.font:UIFont.init(name: (btn.titleLabel?.font.fontName)!, size: (btn.titleLabel?.font.pointSize)!)!])
            titleSize.width += 20;
            btn.frame = CGRect(x: x + 12, y: 0, width: titleSize.width, height: frame.size.height)
            x = btn.frame.maxX
            self.scrollView?.addSubview(btn)
        }
        self.scrollView?.contentSize = CGSize(width: x + 12, height: frame.size.height)
    }
    
    func addScrollView() {
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.bounces = false
        self.scrollView?.bouncesZoom = false
        self.addSubview(self.scrollView!)
    }
    
    @objc func onClick(btn:UIButton){
        //修改选中状态
        if lastSelectedBtn != nil && lastSelectedBtn != btn {
            lastSelectedBtn?.setTitleColor(normalTintColor, for: .normal)
            lastSelectedBtn?.backgroundColor = normalBackgroundColor
        }
        btn.setTitleColor(selectedTintColor, for: .normal)
        btn.backgroundColor = selectedBackgroundColor
        //滚动ScrollView
        if btn.frame.maxX + 12 >= frame.maxX{
            self.scrollView?.setContentOffset(CGPoint(x: btn.frame.minX - frame.size.width/2 - 12, y: 0), animated: true)
        }else {
            self.scrollView?.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        lastSelectedBtn = btn
        if onSelected != nil {
            self.onSelected!(btn.tag-baseBtnTag,btn.currentTitle)
        }
    }
    
}
