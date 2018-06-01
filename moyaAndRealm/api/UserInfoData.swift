//
//  UserInfoData.swift
//  SkinSensor
//
//  Created by king zhu on 2017/2/16.
//  Copyright © 2017年 taiheyifu. All rights reserved.
//用户信息请求存储类

import Foundation
import SwiftyJSON
import RealmSwift



class ZZWUserInfoData:Object{
    @objc dynamic var id : Int = 0
  
    @objc dynamic var days : String = ""
    @objc dynamic var citynm : String = ""
    @objc dynamic var weather_icon : String = ""
    @objc dynamic var wind : String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
    
  
}


class ZZWResponseBase : Object {
    @objc dynamic var id : Int = 0
   
    @objc dynamic var success:String = ""
    
    var result = List<ZZWUserInfoData>()
    
//    @objc dynamic var data: ZZWUserInfoData? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


extension ZZWUserInfoData{
    

   class  func addNewItemInRealm(_ json :JSON) -> List<ZZWUserInfoData>
        
    {
        
        let jsonArr = json.arrayValue

        
        let userList : List<ZZWUserInfoData> = List<ZZWUserInfoData>()
        

        for (index,item) in jsonArr.enumerated() {
        

            let model = ZZWUserInfoData()
        
            model.id =  index// model.generateNewPrimaryKey()
            model.days = item["days"].stringValue
            
            model.citynm = item["citynm"].stringValue
        
            model.weather_icon = item["weather_icon"].stringValue
            
            model.wind = item["wind"].stringValue

//        DispatchQueue(label: "background").async {
//
//
//                try! ZZWRealmManager.shared.realmManager.write({
//
//
//                    ZZWRealmManager.shared.realmManager.add(model, update: true)
//
//                })
            userList.append(model)
        }

        return userList
            
//        }
        
    }

    private func  generateNewPrimaryKey() -> Int {
        var primaryKey : Int = 0;
        
        let results  = ZZWRealmManager.shared.realmManager.objects(ZZWUserInfoData.self)
        if( results.count > 0) {
            let last = results.last
            primaryKey = (last?.id)! + 1
        }
        return primaryKey;
    }
    
    
}


extension ZZWResponseBase{
    
    
    class  func addNewItemInRealm(_ json :JSON) -> ZZWResponseBase
        
    {
        
        //        let jsonArr = json.arrayValue
        //
        //
        //
        //
        //        for item in jsonArr {
        
        
        
        let model = ZZWResponseBase()
        
        model.id =  0// model.generateNewPrimaryKey()
        model.success = json["success"].stringValue
        
       
        
        model.result =  ZZWUserInfoData.addNewItemInRealm(json["result"])
        
  
        
                try! ZZWRealmManager.shared.realmManager.write({
                    
                    
                    ZZWRealmManager.shared.realmManager.add(model, update: true)
                    
                })
        
        return model
        
        //        }
        
    }
    
    private func  generateNewPrimaryKey() -> Int {
        var primaryKey : Int = 0;
        
        let results  = ZZWRealmManager.shared.realmManager.objects(ZZWUserInfoData.self)
        if( results.count > 0) {
            let last = results.last
            primaryKey = (last?.id)! + 1
        }
        return primaryKey;
    }
    
    
}
