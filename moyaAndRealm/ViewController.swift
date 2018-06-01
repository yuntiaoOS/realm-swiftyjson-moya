//
//  ViewController.swift
//  moyaAndRealm
//
//  Created by jcgf on 2018/5/31.
//  Copyright © 2018年 jcgf. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let user : ZZWResponseBase = ZZWRealmManager.shared.realmManager.objects(ZZWResponseBase.self).last!
            
//            getObjectItemsInRealm(ZZWResponseBase.self, realm: ZZWRealmManager.shared.realmManager).last as! ZZWResponseBase
        print(user.success )
        
        let userdetail : ZZWUserInfoData = ZZWRealmManager.shared.realmManager.objects(ZZWUserInfoData.self).last!
        print(userdetail.citynm )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

