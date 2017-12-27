//
//  ViewController.swift
//  SYScrollTabDemo
//
//  Created by Samoy Young on 2017/12/27.
//  Copyright © 2017年 Samoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scrollTab = SYScrollTab(frame: CGRect.init(x: 0, y: 100, width: view.frame.size.width, height: 40), titleArray: ["Tom","Samoy","Make Smith","Jack Young","Ada"])
        scrollTab.onSelected = { (index,title) in
            print("选中了第\(index)个,标题是\(title ?? "")")
        }
        //这句话要放在回调之后，否则无法触发回调
        scrollTab.selctedIndex = 0
        self.view.addSubview(scrollTab)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

