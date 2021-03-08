//
//  AliothViewInfo.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation

public class AliothViewInfo : NSObject, Codable {
    var viewId: String?
    var uniqueKey: String?

    //var parameters: Dictionary<String, Any?>?
    var parameters: String?
    //var results:JSONObject? = null
    var results: String? = nil

    //init(viewId: String, params: Dictionary<String, Any?>, results: String) {
    init(viewId: String?, params: String?, results: String?) {
        super.init()
        
        self.viewId = viewId
        self.uniqueKey = viewId! + UUID.init().uuidString
        self.parameters = params
        self.results = results
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        viewId = try values.decode(String.self, forKey: .viewId)
        uniqueKey = try values.decode(String.self, forKey: .uniqueKey)
        parameters = try values.decode(String.self, forKey: .parameters)
        results = try values.decode(String.self, forKey: .results)
    }
    
    func toJSONString() -> String? {
        let props = [
            "viewId": self.viewId!,
            "uniqueKey": self.uniqueKey!,
            "parameters": self.parameters!,
            "results": self.results!
        ] as [String : Any]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: props, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        }
        catch let error {
            Logger?.Log("Error Converting to JSON. [\(error.localizedDescription)]")
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case viewId
        case uniqueKey
        case parameters
        case results
    }
}

