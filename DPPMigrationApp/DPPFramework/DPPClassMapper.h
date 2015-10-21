@import Foundation;

@class ScreenNodeEntity;

@interface DPPClassMapper : NSObject

- (void)mapClass:(Class)class WithType:(NSString *)type;
- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype;
- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype childNodeType:(NSString *)childType;
- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype childNodeType:(NSString *)childType childNodeSubType:(NSString *)childSubType;
- (Class)getClassForType:(NSString *)type subtype:(NSString *)subtype;
- (id)createClassWithType:(NSString *)type subType:(NSString *)subtype screenNode:(ScreenNodeEntity *)screenNode;
@end
