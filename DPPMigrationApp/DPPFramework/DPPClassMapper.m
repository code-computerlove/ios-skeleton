//
//  DPPClassMapper.m
//  DPPFramework
//
//  Created by matthewcawley on 10/06/2014.
//  Copyright (c) 2014 Code Computerlove. All rights reserved.
//

#import "DPPClassMapper.h"
#import "DPPFramework.h"
#import "DPPMigrationApp-Swift.h"
#import "AppDelegate.h"

#import "DPPMigrationApp-Swift.h"

@interface DPPClassMapper()

@property (strong) NSDictionary *mappedClasses;

@end

@implementation DPPClassMapper


- (instancetype)init {
	
	self = [super init];
	
	if (self) {
		self.mappedClasses = [NSDictionary dictionary];
	}
	
	return self;
}

- (void)mapClass:(Class)class WithType:(NSString *)type {
	[self mapClass:class WithType:type subtype:nil];
}

- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype {
	[self mapClass:class WithType:type subtype:subtype childNodeType:nil];
}

- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype childNodeType:(NSString *)childType {
	[self mapClass:class WithType:type subtype:subtype childNodeType:childType childNodeSubType:nil];
}

- (void)mapClass:(Class)class WithType:(NSString *)type subtype:(NSString *)subtype childNodeType:(NSString *)childType childNodeSubType:(NSString *)childSubType {
	
	if (!subtype) {
		subtype = @"";
	}
	
	if (!childType) {
		childType = @"";
	}
	
	if (!childSubType) {
		childSubType = @"";
	}
	
	NSMutableDictionary *tmpDictionary = [NSMutableDictionary dictionaryWithDictionary:self.mappedClasses];
	[tmpDictionary setValue:class forKey:[NSString stringWithFormat:@"%@%@%@%@", type, subtype, childType, childSubType]];
	
	self.mappedClasses = [NSDictionary dictionaryWithDictionary:tmpDictionary];
}

- (Class)getClassForType:(NSString *)type subtype:(NSString *)subtype {
	
	subtype = (subtype ? subtype : @"");
	NSString *typeKey = [NSString stringWithFormat:@"%@%@", type, subtype];
	
	Class class = self.mappedClasses[typeKey];
	
	if (!class) {
		NSString *extendedTypeKey =  [NSString stringWithFormat:@"%@%@", typeKey, self.mappedClasses[typeKey]];
		class = self.mappedClasses[extendedTypeKey];
	}
	
	if (!class && ![subtype isEqualToString:@""]) {
		class = self.mappedClasses[type];
	}
	
	return class;
}

- (Class)getClassForType:(NSString *)type subtype:(NSString *)subtype childType:(NSString *)childType childSubtype:(NSString *)childSubtype {
	
	subtype = (subtype ? subtype : @"");
	childType = (childType ? childType : @"");
	childSubtype = (childSubtype ? childSubtype : @"");
	NSString *typeKey = [NSString stringWithFormat:@"%@%@%@%@", type, subtype, childType, childSubtype];
	
	Class class = self.mappedClasses[typeKey];
	
	if (!class && ![childSubtype isEqualToString:@""]) {
		NSString *typeKey = [NSString stringWithFormat:@"%@%@%@", type, subtype, childType];
    class = self.mappedClasses[typeKey];
	}
	
	if (!class && ![childType isEqualToString:@""]) {
		NSString *typeKey = [NSString stringWithFormat:@"%@%@", type, subtype];
		class = self.mappedClasses[typeKey];
	}
	
	if (!class && ![subtype isEqualToString:@""]) {
		NSString *typeKey = [NSString stringWithFormat:@"%@", type];
		class = self.mappedClasses[typeKey];
	}
	
	return class;
}


- (id)createClassWithType:(NSString *)type subType:(NSString *)subtype screenNode:(ScreenNodeEntity *)screenNode {
	
	NSString* childType = @"";
	NSString* childSubType  = @"";
	
	NSArray* subNodes = screenNode.screens;
	
	if ([subNodes count] > 0) {
		ScreenNodeEntity* childNode = [subNodes firstObject];
		childType = childNode.screenType;
		childSubType = childNode.screenSubType;
	}
	
	Class class = [self getClassForType:type subtype:subtype childType:childType childSubtype:childSubType];
	
	if (!class) {
		[[[UIAlertView alloc] initWithTitle:@"Node not yet mapped" message:[NSString stringWithFormat:@"The node type '%@%@' has not yet been mapped", type, subtype] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		
		return nil;
	}
	
	if ([class isSubclassOfClass:[UIViewController class]]) {
		if ([class conformsToProtocol:@protocol(DPPScreenRenderRenderable)]) {
			UIViewController<DPPScreenRenderRenderable> *viewController = [[class alloc] initWithScreenNode:(ScreenNodeEntity *)screenNode];
			return viewController;
        } else if ([class isSubclassOfClass:[GridViewViewController class]]) {
    
            
            
        
            return nil;
        } else {
			[[[NSException alloc] initWithName:@"Not renderable" reason:[NSString stringWithFormat:@"ViewController: '%@' must adopt the protocol '%@", NSStringFromClass(class), NSStringFromProtocol(@protocol(DPPScreenRenderRenderable))] userInfo:nil] raise];
		}
	} else {
		[[[NSException alloc] initWithName:@"Invalid Class Type" reason:@"Screen nodes can only be rendered into UIViewControllers" userInfo:nil] raise];
	}
	
	return nil;
	
}


@end
