import Foundation

struct Constants {
    
    struct API {
        static let ContentTypeKey = "Content-Type";
        static let RequestContentType = "application/x-www-form-urlencoded"
        static let ResponseContentTypeValue = "application/json; charset=utf-8";
        static let LanguageURL = "/api/deployment/cultures";
        static let VersionCheckURL = "/api/deployment/version";
        static let DownloadURL = "/api/deployment/download";
        static let DownloadMediaURL = "/api/deployment/media/get";
        
        struct Authentication {
            static let HeaderDateKey = "x-date";
            static let HeaderSignatureKey = "x-signature";
            static let DecryptionKey = "7fa18245-df86-439d-9761-2760f6eb35c6";
        }
        
        struct PostKey {
            static let ApplicationID = "applicationId";
            static let Version = "version";
            static let ContentMode = "contentMode";
            static let Path = "path";
            static let DeviceToken = "deviceToken";
        }
    }
}