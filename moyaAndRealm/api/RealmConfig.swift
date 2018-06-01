//
//  RealmConfig.swift
//  moyaAndRealm
//
//  Created by jcgf on 2018/5/31.
//  Copyright © 2018年 jcgf. All rights reserved.
//

import Foundation
import RealmSwift

class ZZWRealmManager: NSObject {
    static let shared = ZZWRealmManager()
    let realmManager : Realm = realmConfig()
}


public func realmConfig() -> Realm {
        
        
        // 默认将 Realm 放在 App Group 里
        
        //    let directory: NSURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Config.appGroupID)! as NSURL
        //    let realmFileURL = directory.appendingPathComponent("db.realm")
        
        let directory: URL = URL.init(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true).first!)
        let realmFileURL = directory.appendingPathComponent("db.realm")
        
        
        var config = Realm.Configuration()
        config.fileURL = realmFileURL
        config.schemaVersion = 1
        config.migrationBlock = { migration, oldSchemaVersion in
            
            print(migration)
        }
    
        
        return try! Realm(configuration: config)
    }
    
    func cleanRealmAndCaches() {
        
        // clean Realm
        
       
        
        let _ = try? ZZWRealmManager.shared.realmManager.write {
            ZZWRealmManager.shared.realmManager.deleteAll()
        }
        
        ZZWRealmManager.shared.realmManager.refresh()
        
        
    }
    
    
    
    // 获取某一个模型的数据
    
    
    func getObjectItemsInRealm(_ objectType: Object.Type,realm : Realm) -> Results<Object>
        
    {
        
        let items = realm.objects(objectType)
        
        return items
        
    }
    
    // 删除某一个对象的所有数据
    
    func deleteAllObject(_ objectType: Object.Type)
        
    {
        
        
            
            let items = ZZWRealmManager.shared.realmManager.objects(objectType)
            
            
            
            try! ZZWRealmManager.shared.realmManager.write({
                
                ZZWRealmManager.shared.realmManager.delete(items)
                
            })
            
        
        
    }



