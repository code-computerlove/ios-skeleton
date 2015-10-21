//
//  DPPContentNodeManager.h
//  DPPFramework
//
//  Created by matthewcawley on 10/06/2014.
//  Copyright (c) 2014 Code Computerlove. All rights reserved.
//

@class MediaEntity;
@class ScreenNodeEntity;
@class TabletoResponseEntity;

@interface DPPContentNodeManager : NSObject

@property (strong) NSString *quickLinksTitle;

- (MediaEntity *)getMediaNodeWithId:(NSString *)nodeId;
- (ScreenNodeEntity *)getScreenNodeWithId:(NSString *)nodeId;
- (ScreenNodeEntity *)getRootNode;

- (NSArray *)getChildNodesForNode:(ScreenNodeEntity *)screenNode;

- (void)loadNodesFromContentModel:(TabletoResponseEntity *)contentModel;
- (NSArray *)getQuickLinks;

- (NSArray *)getScreenNodesForSearchTerm:(NSString *)searchTerm;


@end
