//
//  simplePacket.swift
//  JsonObject
//
//  Created by ITTF04 on 2021/03/04.
//

import Foundation

//struct simplePacket : Codable {
public class simplePacket : Codable {
    var tag: String?
    var msg: String?

    init(tag: String?, msg: String?) {
        self.tag = tag
        self.msg = msg
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decode(String.self, forKey: .tag)
        msg = try values.decode(String.self, forKey: .msg)

    }
    
    func toJson() -> String? {
        let props = ["tag": self.tag, "msg": self.msg]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: props, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case tag
        case msg
    }
}
