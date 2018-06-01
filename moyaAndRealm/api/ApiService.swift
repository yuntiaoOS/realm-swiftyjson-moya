//
//  ApiService.swift
//
//  Created by Kooze on 16/6/27.
//  Copyright © 2016年 purisen. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON



var strActionPath = ""


let appendedParams: Dictionary<String, AnyObject> = [

:]


public var parameterEncoding: ParameterEncoding {
    
    
    return JSONEncoding.prettyPrinted
}

var endpointClosure = { (target: ApiService) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let headF = target.headers
    
    
    return Endpoint(
        url: url,
        sampleResponseClosure: {
            .networkResponse(200, target.sampleData)
            
    },
        method: target.method,
        task: target.task,
        
        httpHeaderFields: headF

    )

}

var endpointClosureWeb = { (target: ApiService) -> Endpoint in
    let url = target.path
    let headF = target.headers
   
    return Endpoint(url: url,
                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: headF)

    
    
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

let networkPlugin = NetworkActivityPlugin { type,target   in
    
    if (UIApplication.shared.keyWindow != nil) {
        switch type {
        case .began:

            break
        case .ended:

            break
        }
    }
    
    
    

}



let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<ApiService>.RequestResultClosure) in
    
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 10.0    //设置请求超时时间
        // Modify the request however you like.
        
        switch endpoint.sampleResponseClosure() {
            
        case .networkResponse(let statusCode, let data):

                break

        case .networkError(let error):
            let error = Moya.MoyaError.underlying(error, nil)
  
        default: break

        }
        
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error,nil)))
    }

}



let apiProvider = MoyaProvider<ApiService>(endpointClosure: endpointClosure,requestClosure: requestClosure, plugins: [networkPlugin])
let webProvider = MoyaProvider<ApiService>(endpointClosure:endpointClosureWeb)

enum ApiService {
   
    //加载非标准接口
    case loadWebPage(pageUrl:String)
}



extension ApiService: TargetType {
    var headers: [String : String]? {
        return [
           
            :]
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.prettyPrinted
    }

   
  
    var baseURL: URL {return URL(string: "http://api.k780.com/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!}

    var path: String {
        switch self {
        
        case .loadWebPage(let pathPage):
            return pathPage

        }
        
    }
    
    var method: Moya.Method {
        
        switch self {
        case .loadWebPage( _):
            return .get
       
        }

    }
    
    var parameters: [String: Any]? {
        
        switch self {
       
        case .loadWebPage(_):
            return nil
        
        }
    }
    

    public var task: Task {
    
        switch self {
        case .loadWebPage( _):
            return .requestPlain
    
        }
        
    }
    public var sampleData: Data {
        switch self {
        default:
            return "Success".data(using: String.Encoding.utf8)!
        
        }
    }
    
}





