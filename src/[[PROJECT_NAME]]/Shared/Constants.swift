import Foundation


struct Constants {
    struct API {
        static let ContentTypeKey = "Content-Type";
        static let RequestContentType = "application/x-www-form-urlencoded"
        static let ResponseContentTypeValue = "application/json; charset=utf-8";
        
        struct Authentication {
            static let HeaderDateKey = "x-date";
            static let HeaderSignatureKey = "x-signature";
            static let DecryptionKey = "";
        }
        
        struct PostKey {
            static let DeviceToken = "deviceToken";
        }
    }
}