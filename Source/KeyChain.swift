//
//  MacOS 13.0
//  Swift 5.0
//  prod
//

import Security


internal class KeyChain {
    enum ValueType: String {
        case givenName, familyName, email
    }
    
    static let shared = KeyChain()
    
    private init() { }
    

    
    @discardableResult func save(key: String, type: ValueType, data: Data?) -> OSStatus? {
        guard let data else {return nil}
        let key = "\(key)_\(type.rawValue)"
        let query = [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String : data
        ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    func load(key: String, type: ValueType) -> String? {
        let key = "\(key)_\(type.rawValue)"
        
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne
        ] as [String : Any]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return (dataTypeRef as? Data)?.inString
        } else {
            return nil
        }
    }
}

private extension Data {
    var inString: String {
        return String(decoding: self, as: UTF8.self)
    }
}
