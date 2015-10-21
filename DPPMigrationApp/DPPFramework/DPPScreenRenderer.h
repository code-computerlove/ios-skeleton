@import Foundation;
@import UIKit;

@class DPPScreenNode;

@protocol DPPScreenRenderRenderable <NSObject>

@required
@property (strong) DPPScreenNode *screenNode;
@property (strong) DPPScreenNode *activeScreenNode; //this is used to denote the focused screen node, useful for scrolling content etc.
- (instancetype)initWithScreenNode:(DPPScreenNode *)screenNode;

@end

@interface DPPScreenRenderer : NSObject

- (void)renderScreenNodeInNewStack:(DPPScreenNode *)screenNode;

- (UIViewController *)renderScreenNode:(DPPScreenNode *)screenNode;
- (UIViewController *)getRenderedScreenNode:(DPPScreenNode *)screenNode;

@end
