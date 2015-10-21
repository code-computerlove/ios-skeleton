//
//  DPPScreenRenderer.m
//  DPPFramework
//
//  Created by matthewcawley on 10/06/2014.
//  Copyright (c) 2014 Code Computerlove. All rights reserved.
//

#import "DPPScreenRenderer.h"
#import "DPPFramework.h"
#import "DPPScreenNode.h"

#import "DPPMigrationApp-Swift.h"

@implementation DPPScreenRenderer

- (UIViewController *)getRenderedScreenNode:(ScreenNodeEntity *)screenNode
{
	return (UIViewController*)[[DPPFramework sharedFramework].classMapper createClassWithType:screenNode.screenType subType:screenNode.screenSubType screenNode:screenNode];
}

- (UIViewController *)renderScreenNode:(ScreenNodeEntity *)screenNode
{
    UIViewController *viewController = [self getRenderedScreenNode:screenNode];
    [[DPPFramework sharedFramework].masterViewController showViewController:viewController];
	
    return viewController;
}

- (void)renderScreenNodeModally:(ScreenNodeEntity *)screenNode
{
    [self renderScreenNodeModally:screenNode inNavigationController:NO];
}

- (void)renderScreenNodeModally:(ScreenNodeEntity *)screenNode inNavigationController:(BOOL)inNavigationController
{
    [self renderScreenNodeModally:screenNode inNavigationController:NO asDialog:NO];
}

- (void)renderScreenNodeModally:(ScreenNodeEntity *)screenNode inNavigationController:(BOOL)inNavigationController asDialog:(BOOL)asDialog
{
    UIViewController *viewController = [self getRenderedScreenNode:screenNode];
    [[DPPFramework sharedFramework].masterViewController showViewControllerModally:viewController inNavigationController:inNavigationController asDialog:asDialog];
}

@end
