//
//  ViewController.swift
//  LocationPlugin
//
//  Created by 1260197127@qq.com on 12/05/2019.
//  Copyright (c) 2019 1260197127@qq.com. All rights reserved.
//

import UIKit
import LocationPlugin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        LocationManager.default.requestLocation().responseResult { (locationResponse) in
            if let error = locationResponse.error {
                print("定位信息获取失败: \(error)")
            }else {
                print(locationResponse.coordinate!)
            }
        }
        
        LocationManager.default.requestLocation().didUpdateResult { (response) in
            if let error = response.error {
                print("定位信息获取失败:\(error)")
            }else {
                print(response.coordinate!)
            }
        }
        
       
    }

}

