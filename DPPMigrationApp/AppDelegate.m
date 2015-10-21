#import "AppDelegate.h"
#import "DPPConstants.h"
#import "DPPViewModules.h"
#import "DPPNavigationBarButtonItem.h"
#import "DPPNavigationController.h"

#import "DPPMigrationApp-Swift.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self mapClasses];
    [self mapNavigationBarItems];
	
	AppConfig *appConfig = [self createAppConfiguration];
	self.mainWireframe = [[MainWireframe alloc] initWithWindow:self.window config:appConfig];
	
    NSString *gaTrackingId = [[DPPFramework sharedFramework].config
							  getConfigValueForKey:DPPConfigKeyGoogleAnalyticsTrackingId];
    [DPPAnalyticsManager createTrackerWithTrackingId:gaTrackingId];
    
    [[DPPFramework sharedFramework].leaveBehindManager loadLeaveBehind];
    
    return YES;
}

- (AppConfig *)createAppConfiguration {
	
	AppConfig *appConfig = [[AppConfig alloc] init];
	
	NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSString *contentDirPath = [documentsPath stringByAppendingPathComponent:@"content"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:contentDirPath]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:contentDirPath withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	NSString *appContentFilePath = [contentDirPath stringByAppendingPathComponent:@"content.json"];
	
	appConfig.contentExists = [[NSFileManager defaultManager] fileExistsAtPath:appContentFilePath];
	appConfig.appContentFilePath = appContentFilePath;
	
	return appConfig;
}


- (void) mapClasses {
	
	//Bypass membership functionality
	[[DPPFramework sharedFramework].config setConfigValue:@"d61de504-70a1-4087-a1ef-7648024b8af7" forKey:@"DPPAuthToken"];
    
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMFullScreenImageViewController class] WithType:@"image"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMScrollerViewController class] WithType:@"scroll"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMWebPageViewController class] WithType:@"web"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMFullScreenConentViewController class] WithType:@"page"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMScrollerViewController class] WithType:@"productgroup"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMFullScreenConentViewController class] WithType:@"product"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMGalleryViewController class] WithType:@"gallery"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMFullScreenImageViewController class] WithType:@"galleryitem"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMInContentScrollContentViewController class] WithType:@"scrollcontent"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMInContentScrollerViewController class] WithType:@"scroll" subtype:@"vertical" childNodeType:@"scrollcontent"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMVideoViewController class] WithType:@"video"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMFileViewerViewController class] WithType:@"file"];
	[[DPPFramework sharedFramework].classMapper mapClass:[DPPVMParallaxMenuViewController class] WithType:@"parallax-grid"];
}

- (void)mapNavigationBarItems {
	
	DPPNavigationBarButtonItem* searchMenuItem =
	[[DPPNavigationBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search"]
												style:UIBarButtonItemStylePlain
												title:@"Search"
										shouldCascade:NO];
	
	[searchMenuItem mapToClass:[DPPVMSearchViewController class]];
	[[DPPFramework sharedFramework].navigationBarManager addActionBarItem:searchMenuItem];
	
	DPPNavigationBarButtonItem* favouriteMenuItem =
	[[DPPNavigationBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fav_btn"]
												style:UIBarButtonItemStylePlain
												title:@"Add to favourites"
										shouldCascade:YES];
	
	[favouriteMenuItem setTarget:[DPPFramework sharedFramework].favouritesManager
						  action:@selector(toggleFavouriteScreenNode)];
	
	[favouriteMenuItem setCheckTarget:[DPPFramework sharedFramework].favouritesManager
						checkSelector:@selector(isVisibleScreenNodeFavourited)];
	
	[favouriteMenuItem setActiveImage:[UIImage imageNamed:@"fav_btn_selected"]
						inactiveImage:[UIImage imageNamed:@"fav_btn"]];
	[favouriteMenuItem setActiveTitle:@"Remove from favourites"
						inactiveTitle:@"Add to favourites"];
	[favouriteMenuItem setBlockedScreenTypes:@[[DPPVMGridViewController class],
											   [DPPLeaveBehindPreviewViewController class]]];
	
	[[DPPFramework sharedFramework].navigationBarManager addActionBarItem:favouriteMenuItem];
	
//	if ([UIPrintInteractionController isPrintingAvailable]) {
//		DPPNavigationBarButtonItem* printMenuItem =
//		[[DPPNavigationBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fav_btn"]
//													style:UIBarButtonItemStylePlain
//													title:@"Print Screen"
//											shouldCascade:YES];
//
//		[printMenuItem setTarget:[DPPFramework sharedFramework].leaveBehindManager
//						  action:@selector(printCurrentScreenNode)];
//		[printMenuItem setBlockedScreenTypes:@[[DPPVMGridViewController class],
//											   [DPPLeaveBehindPreviewViewController class]]];
//		
//		[[DPPFramework sharedFramework].navigationBarManager addActionBarItem:printMenuItem];
//	}
	
//	DPPNavigationBarButtonItem* leaveBehindMenuItem =
//	[[DPPNavigationBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fav_btn"]
//												style:UIBarButtonItemStylePlain
//												title:@"Add to leave behind"
//										shouldCascade:YES];
//	
//	[leaveBehindMenuItem setTarget:[DPPFramework sharedFramework].leaveBehindManager
//							action:@selector(toggleLeaveBehindScreenNode)];
//	[leaveBehindMenuItem setCheckTarget:[DPPFramework sharedFramework].leaveBehindManager
//						  checkSelector:@selector(isVisibleScreenNodeInLeaveBehind)];
//	[leaveBehindMenuItem setActiveTitle:@"Remove from leave behind"
//						  inactiveTitle:@"Add to leave behind"];
//	[leaveBehindMenuItem setBlockedScreenTypes:@[[DPPVMGridViewController class],
//												 [DPPLeaveBehindPreviewViewController class]]];
//	
//	[[DPPFramework sharedFramework].navigationBarManager addActionBarItem:leaveBehindMenuItem];
//	
//	DPPNavigationBarButtonItem* leaveBehindPreviewMenuItem =
//	[[DPPNavigationBarButtonItem alloc] initWithImage:nil
//										 style:UIBarButtonItemStylePlain
//										 title:@"Preview leave behind"
//								 shouldCascade:YES];
//	 
//	[leaveBehindPreviewMenuItem setTarget:[DPPFramework sharedFramework].leaveBehindManager
//								   action:@selector(previewLeaveBehind)];
//	[leaveBehindPreviewMenuItem setBlockedScreenTypes:@[[DPPLeaveBehindPreviewViewController class]]];
//	 
//	[[DPPFramework sharedFramework].navigationBarManager addActionBarItem:leaveBehindPreviewMenuItem];
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[request.URL scheme] isEqualToString:@"pres"]) {
        
        DPPScreenNode *screen = [[DPPFramework sharedFramework].contentNodeManager getScreenNodeWithId:[request.URL resourceSpecifier]];
        [[DPPFramework sharedFramework].screenRenderer renderScreenNode:screen];
        
        return NO;
        
    } else {
        //ordinary link
        if (navigationType == UIWebViewNavigationTypeLinkClicked) {
            [[UIApplication sharedApplication] openURL:[request URL]];
            return NO;
        }
        
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (webView.scrollView.contentSize.height <= webView.frame.size.height) {
        [webView.scrollView setBounces:NO];
    } else {
        [webView .scrollView setBounces:YES];
    }
}


@end
