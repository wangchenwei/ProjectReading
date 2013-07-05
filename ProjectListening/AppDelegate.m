//
//  AppDelegate.m
//  ProjectListening
//
//  Created by zhaozilong on 13-3-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "LibraryTableViewController.h"
#import "NewWordsViewController.h"
#import "InAppSettingsKit/Controllers/IASKAppSettingsViewController.h"
#import "UserSetting.h"
#import "NSDate+ZZDate.h"
#import "Flurry/Flurry.h"

#include <sqlite3.h>
#import "NewWordsViewController.h"

#define TAG_NAV_1 111
#define TAG_NAV_2 222
#define TAG_NAV_3 333
#define TAG_NAV_4 444

@interface AppDelegate ()

//@property (nonatomic, retain) LeveyTabBarController *leveyTabBarController;
@property (nonatomic, retain) UITabBarController *rootTabBarController;

@property (nonatomic, retain) UIViewController *firstRunViewController;

@end

@implementation AppDelegate

@synthesize window;
//@synthesize leveyTabBarController;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

//Flurry捕获异常
void uncaughtExceptionHandler(NSException *exception) {
	[Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
	// Init the window
//	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
    /*
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
     */
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
    //加tabbar
    RootViewController *vc_1 = nil;
	LibraryTableViewController *vc_2 = [[LibraryTableViewController alloc] initWithNibName:@"LibraryTableViewController" bundle:nil];
	NewWordsViewController *vc_3 = [[NewWordsViewController alloc] initWithNibName:@"NewWordsViewController" bundle:nil];
	IASKAppSettingsViewController *vc_4 = [[IASKAppSettingsViewController alloc] init];
    
    NSString *RVCNibName = nil;
    NSString *LTVCNibName = nil;
    NSString *NVCNibName = nil;
    if (IS_IPAD) {
        RVCNibName = @"RootViewController-iPad";
        LTVCNibName = @"LibraryTableViewController-iPad";
        NVCNibName = @"NewWordsViewController-iPad";
    } else {
        RVCNibName = @"RootViewController";
        LTVCNibName = @"LibraryTableViewController";
        NVCNibName = @"NewWordsViewController";
    }
    vc_1 = [[RootViewController alloc] initWithNibName:RVCNibName bundle:nil];
    vc_2 = [[LibraryTableViewController alloc] initWithNibName:LTVCNibName bundle:nil];
    vc_3 = [[NewWordsViewController alloc] initWithNibName:NVCNibName bundle:nil];
    
	UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:vc_1];
	[vc_1 release];
//    nav_1.delegate = self;
    nav_1.navigationBar.tag = TAG_NAV_1;
    [nav_1.navigationBar setBackgroundImage:[UIImage imageNamed:@"navStyle.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:vc_2];
	[vc_2 release];
//    nav_2.delegate = self;
    nav_2.navigationBar.tag = TAG_NAV_2;
    [nav_2.navigationBar setBackgroundImage:[UIImage imageNamed:@"navStyle.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav_3 = [[UINavigationController alloc] initWithRootViewController:vc_3];
    
	[vc_3 release];//ARC不需要release
//    nav_3.delegate = self;
    nav_3.navigationBar.tag = TAG_NAV_3;
    [nav_3.navigationBar setBackgroundImage:[UIImage imageNamed:@"navStyle.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav_4 = [[UINavigationController alloc] initWithRootViewController:vc_4];
	[vc_4 release];
//    nav_4.delegate = self;
    nav_4.navigationBar.tag = TAG_NAV_4;
    [nav_4.navigationBar setBackgroundImage:[UIImage imageNamed:@"navStyle.png"] forBarMetrics:UIBarMetricsDefault];
    
	NSArray *ctrlArr = [NSArray arrayWithObjects:nav_1,nav_2,nav_3,nav_4,nil];
    [nav_1 release];
    [nav_2 release];
    [nav_3 release];
    [nav_4 release];
    
    _rootTabBarController = [[UITabBarController alloc] init];
    [_rootTabBarController setViewControllers:ctrlArr];
    [_rootTabBarController setDelegate:self];
    [_rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"c-2-1.png"]];
    [self appearenceTabbar:_rootTabBarController];
    [self.window addSubview:_rootTabBarController.view];
    
    
    [self.window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
    
    [AppDelegate createLocalNotification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //FlurryAnalytics:begin receiving basic metric data
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	[Flurry startSession:FLURRY_ID];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
    
    
    
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
//	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //	if ([viewController isKindOfClass:[SecondViewController class]])
    //	{
    //        [leveyTabBarController hidesTabBar:NO animated:YES];
    //	}
    if (navigationController.navigationBar.tag == TAG_NAV_3) {
        if ([viewController isKindOfClass:[NewWordsViewController class]]) {
//            [UIView  beginAnimations:nil context:NULL];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            [UIView setAnimationDuration:0.75];
//            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
//            [UIView commitAnimations];
//            
//            [UIView beginAnimations:nil context:NULL];
//            [UIView setAnimationDelay:0.375];
//            [self.navigationController popViewControllerAnimated:NO];
//            [UIView commitAnimations];
        }
    }
    
    
    if (viewController.hidesBottomBarWhenPushed)
    {
//        [_leveyTabBarController hidesTabBar:YES animated:YES];
    }
    else
    {
//        [_leveyTabBarController hidesTabBar:NO animated:YES];
    }
}
*/

- (BOOL)tabBarController:(UITabBarController *)theTabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if (theTabBarController.selectedViewController == viewController && [viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *v = (UINavigationController *)viewController;
        if (v.navigationBar.tag == TAG_NAV_3) {
            return NO;
        }
    }
 
    
    return YES;
    
}

- (void)appearenceTabbar:(UITabBarController *)tabbar{
    [tabbar.tabBar setBackgroundImage:[UIImage imageNamed:@"c-2-1.png"]];
    [tabbar.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"barIndicator.png"]];
    //本地化一下子
    NSArray *nameArray = [NSArray arrayWithObjects:@"计划", @"题库", @"收藏", @"更多", nil];
    NSArray * controllers = tabbar.viewControllers;
    for (int i = 0; i < controllers.count; i++) {
        UIViewController * controller = [controllers objectAtIndex:i];
        controller.tabBarItem = [[[UITabBarItem alloc] initWithTitle:[nameArray objectAtIndex:i] image:nil tag:0] autorelease];
        NSString *name = [NSString stringWithFormat:@"00%d_%d.png", i+1, i+1];
        [[controller tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"00%d.png",i + 1]] withFinishedUnselectedImage:[UIImage imageNamed:name]];
        [[controller tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:@"Verdana-Bold" size:10], UITextAttributeFont,
                                                         nil] forState:UIControlStateNormal];
        
    }
}

+ (void)cancelLocalNotification {
    // 获得 UIApplication
//    UIApplication *app = [UIApplication sharedApplication];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    //获取本地推送数组
//    NSArray *localArray = [app scheduledLocalNotifications];
//    //声明本地通知对象
//    UILocalNotification *localNotification = nil;
//    if (localArray) {
//        for (UILocalNotification *noti in localArray) {
//            NSDictionary *dict = noti.userInfo;
//            if (dict) {
//                NSString *inKey = [dict objectForKey:@"key"];
//                if ([inKey isEqualToString:@"name"]) {
//                    if (localNotification){
//                        [localNotification release];
//                        localNotification = nil;
//                    }
//                    localNotification = [noti retain];
//                    break;
//                }
//            }
//        }
//        
//        //判断是否找到已经存在的相同key的推送
//        if (!localNotification) {
//            //不存在初始化
//            localNotification = [[UILocalNotification alloc] init];
//        }
//        
//        if (localNotification) {
//            //不推送 取消推送
//            [app cancelLocalNotification:localNotification];
//            [localNotification release];
//            return;
//        }
//    }
}

+ (void)createLocalNotification {
    
    if (![UserSetting isPushDate]) {
        return;
    }
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif) {
        
        NSArray *pushDateArray = [UserSetting pushHourAndMinAndAMPM];
        int hour = [[pushDateArray objectAtIndex:0] intValue];
        int min = [[pushDateArray objectAtIndex:1] intValue];
        NSString *amOrPm = [pushDateArray objectAtIndex:2];
        if ([amOrPm isEqualToString:@"PM"]) {
            hour += 12;
        }
        
//        NSString *dateStr = [NSString stringWithFormat:@"0001-01-01 %d:%d:00", hour, min];//传入时间
        //将传入时间转化成需要的格式
//        NSDateFormatter *format=[[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *fromdate=[format dateFromString:dateStr];
//        [format release];
//        NSLog(@"Local fromdate=%@",[NSDate getLocateDate:fromdate]);
//        NSLog(@"fromdate=%@",fromdate);

        
        NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
        [components setHour:hour];
        [components setMinute:min];
        
        //本地化一下子
        NSCalendar *localCalendar = [NSCalendar currentCalendar];
        
        NSDate *date = [localCalendar dateFromComponents:components];
        
        localNotif.fireDate = date;
        
        
#if COCOS2D_DEBUG
        NSLog(@"hour is %d, min is %d\n下次推送时间是%@", hour, min, localNotif.fireDate);
#endif
        
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        localNotif.repeatInterval = NSDayCalendarUnit;
        
        //本地化一下子
        NSString *pushStr = nil;
        switch ([UserSetting assistantID]) {
            case 0://大椰
                pushStr = NSLocalizedString(@"大椰助理:嘿!老大,到时间学习了。外语学习是要坚持才能看到成绩的哦。", @"alertBody");
                break;
                
            case 1://小桃
                pushStr = NSLocalizedString(@"小桃助理:主人,学习的时间到了哦。外语学习贵在坚持,我在应用里等着主人哦~", @"alertBody");
                break;
                
            default:
                pushStr = NSLocalizedString(@"助理:主人,学习的时间到了哦。", @"alertBody");
                break;
        }
        localNotif.alertBody = pushStr;
        localNotif.alertAction = NSLocalizedString(@"确定", @"alertAction");
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        
        localNotif.applicationIconBadgeNumber = 1;
        
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        localNotif.userInfo = info;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
    [localNotif release];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive) {
//        NSLog(@"received a local notification while running in the foreground");
    } else if (application.applicationState == UIApplicationStateInactive) {
//        NSLog(@"received a local notification while running in the background");
    }
    
//    [self handleLocalNotificaion:notification];
    
}

#if 0
- (void)handleLocalNotificaion:(UILocalNotification*)localNotification
{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if (localNotification == nil) return;
    
    NSString* soundName = localNotification.soundName;
    if (soundName != nil) {
        [self playSoundWithName:soundName];
    }
    
}


- (void)playSoundWithName:(NSString*)soundName
{
    NSString* extension = [soundName pathExtension];
    NSRange extensionRange = [soundName rangeOfString:extension];
    NSString* fileName = [soundName substringToIndex:(extensionRange.location-1)];
    
    // Get the URL to the sound file to play
    CFURLRef soundFileURLRef  = CFBundleCopyResourceURL(CFBundleGetMainBundle(),
                                                        ( CFStringRef)(fileName),
                                                        ( CFStringRef)(extension),
                                                        NULL);
    
    SystemSoundID soundFileObject;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundFileObject);
    
    AudioServicesPlaySystemSound(soundFileObject);
}
#endif

//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // Override point for customization after application launch.
//    [self performSelectorOnMainThread:@selector(launchWithOptions:) withObject:launchOptions waitUntilDone:NO];
//    return YES;
//}
//                                                
//                                                
//- (void)launchWithOptions:(NSDictionary *)launchOptions {
//        UILocalNotification* localNotification = nil;
//    
//        localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
//        [self handleLocalNotificaion:localNotification];
//}

@end
