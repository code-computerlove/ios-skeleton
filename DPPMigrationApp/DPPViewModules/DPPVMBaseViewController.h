//
//  DPPVMBaseViewController.h
//  DPPViewModules
//
//  Created by matthewcawley on 01/07/2014.
//  Copyright (c) 2014 Code Computerlove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPPScreenRenderer.h"
#import "DPPScreenNode.h"
#import "DPPFramework.h"
#import "DPPScreenNode.h"
#import "DPPMediaNode.h"
#import <Haneke/Haneke.h>

@interface DPPVMBaseViewController : UIViewController <DPPScreenRenderRenderable>

- (id)initWithScreenNode:(ScreenNodeEntity *)screenNode;

@end
