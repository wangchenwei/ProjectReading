//
//  AppDelegate.h
//  ProjectListening
//
//  Created by zhaozilong on 13-3-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LeveyTabBar.h"
//#import "LeveyTabBarController.h"


@class RootViewController;
//@class LeveyTabBarController;

@interface AppDelegate : NSObject <UIApplicationDelegate, /*UINavigationControllerDelegate, */UITabBarControllerDelegate> {
	UIWindow			*window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

+ (void)createLocalNotification;
+ (void)cancelLocalNotification;

@end
