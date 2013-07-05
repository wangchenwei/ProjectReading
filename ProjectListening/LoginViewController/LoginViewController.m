//
//  LoginViewController.m
//  CET4Lite
//
//  Created by Seven Lee on 12-4-16.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "LoginViewController.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "SFHFKeychainUtils.h"
#import "RegisterViewController.h"
#import "Reachability.h"
#import "UserInfo.h"
//#import "AppDelegate.h"
#import "NSString+MD5.h"

@interface LoginViewController ()

@property (nonatomic, retain)ASIHTTPRequest *YuBiRequest;

@end

@implementation LoginViewController
@synthesize PassWordTextField;
@synthesize UsrNameTextField;
@synthesize CurrentUsrLabel;
@synthesize LoginView;
@synthesize LogoutView;
@synthesize navBar;
@synthesize PresOrPush;
@synthesize RemPasswordBtn;
@synthesize YuBLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString * nibName = @"LoginViewController";
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        LoggedIn = [UserInfo userLoggedIn];
        self.PresOrPush = NO; // default push
        
        [self setHidesBottomBarWhenPushed:YES];
        
        //此处为arc，但是backbtn release了
        [ZZPublicClass setBackButtonOnTargetNav:self action:@selector(backToTop)];
        
    }
    return self;
}

- (void)backToTop {
    HUD.delegate = nil;
//    if (_YuBiRequest) {
//        [_YuBiRequest clearDelegatesAndCancel], _YuBiRequest = nil;
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    self.navigationController.navigationBarHidden = YES;
    self.title = @"用户登录";
    self.CurrentUsrLabel.text = [UserInfo loggedUserName];
//    [UserInfo setLoggedUserName:self.CurrentUsrLabel.text];
//    self.CurrentUsrLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kLoggedUserKey];
    NSString * user = [UserInfo loggedUserName];
    //    NSString * user = [[NSUserDefaults standardUserDefaults] objectForKey:kLoggedUserKey];
    if ([user isEqualToString:@""] || user == nil) {
        LoggedIn = NO;
        self.LogoutView.hidden = YES;
        self.LoginView.hidden = NO;
    }
    else {
        LoggedIn = YES;
        [self LoginViewWillAppear:user];
        self.LoginView.hidden = YES;
        self.LogoutView.hidden = NO;
        self.CurrentUsrLabel.text = user;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
}
//- (void) viewDidAppear:(BOOL)animated{
//    if (!PresOrPush) {
//        //        self.navigationController.navigationBarHidden = YES;
//        [self.view setFrame:CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height)];
//        
//    }
//    [super viewDidAppear:animated];
//}
- (void)LoginViewWillAppear:(NSString *) user{
    self.CurrentUsrLabel.text = user;
    self.YuBLabel.text = @"正在获取...";
    Reachability * reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        self.YuBLabel.text = @"无网络连接";
    }
    else {
//        NSString * userID = [UserInfo loggedUserID];
//        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:kLoggedUserID];
//        NSString *url = [NSString stringWithFormat:@"http://app.iyuba.com/pay/checkApi.jsp?userId=%@",userID];
//        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//        _YuBiRequest = request;
//        request.delegate = self;
//        [request setUsername:@"yub"];
//        [request startAsynchronous];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)RemeberSNPressed:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (IBAction)Login:(UIButton *)sender{
    if (self.PassWordTextField.text.length > 0 && self.UsrNameTextField.text.length > 0) {
        NSString * username = self.UsrNameTextField.text;
        NSString * password = [self.PassWordTextField.text MD5String];
        NSString * sign = [[NSString stringWithFormat:@"10001%@%@iyubaV2",username,password] MD5String];
        NSString * urlStr = [NSString stringWithFormat:@"http://apis.iyuba.com/v2/api.iyuba?protocol=10001&username=%@&password=%@&sign=%@&format=xml",username,password,sign];
//        NSString * urlstr = [NSString stringWithFormat:@"http://api.iyuba.com/mobile/ios/cet6/login.xml?username=%@&password=%@&md5status=0",self.UsrNameTextField.text,self.PassWordTextField.text];
#if COCOS2D_DEBUG
        NSLog(@"url:%@",urlStr);
#endif
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        request.delegate = self;
        request.timeOutSeconds = 20;
        [request setUsername:@"log"];
        [request startSynchronous];
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"信息为空" message:@"请输入您的用户名和密码！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
- (IBAction)GoToRegister:(UIButton *)sender{
    self.CurrentUsrLabel.text = @"";
    [UserInfo logOut];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLoggedUserKey];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLoggedUserID];
    self.LogoutView.hidden = YES;
    self.LoginView.hidden = NO;
    RegisterViewController * regi = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    if (PresOrPush) {
        regi.navigationItem.hidesBackButton = YES;
    }
    
    if (IS_IPAD) {
        regi.view.bounds = CGRectMake(0, 0, 400, 480);
    }
    
//    [self presentModalViewController:regi animated:YES];
    [self.navigationController pushViewController:regi animated:YES];
    
}
- (IBAction)Logout:(UIButton *)sender{
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
	[self.view.window addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"正在注销";
	
    //    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLoggedUserID];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLoggedUserKey];
    [UserInfo logOut];
    self.LogoutView.hidden = YES;
    self.LoginView.hidden = NO;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"注销成功";
	sleep(1);
    
}

- (IBAction)Cancel:(id)sender{
    HUD.delegate = nil;
    [self popMyself];
}

- (void) popMyself{
    if (PresOrPush) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == 0) //UsrName
        [PassWordTextField becomeFirstResponder];
    else 
        [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        //        KeychainItemWrapper * keychain = [[KeychainItemWrapper alloc] initWithIdentifier:textField.text accessGroup:nil];
        NSString * pass = [SFHFKeychainUtils getPasswordForUsername:textField.text andServiceName:kMyAppService error:nil];
        if (pass) {
            self.PassWordTextField.text = pass;
            self.RemPasswordBtn.selected = YES;
        }
        
    }
    return YES;
}
#pragma mark -
#pragma ASIHTTPRequestDelegate
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([request.username isEqualToString:@"log"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请检查您的网络设置" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    if ([request.username isEqualToString:@"yub"]) {
        self.YuBLabel.text = @"网络连接失败";
    }
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"yub"]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *amount = [[obj elementForName:@"amount"] stringValue];
                self.YuBLabel.text = amount;
            }
        }
    }
    
    if ([request.username isEqualToString:@"log" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *result = [[obj elementForName:@"result"] stringValue];
                //                s(@"status:%@",status);
                if ([result isEqualToString:@"101"]) {
                    
                    NSString *realUsername = [[obj elementForName:@"username"] stringValue];
                    [UserInfo setLoggedRealUserName:realUsername];
                    [UserInfo setLoggedUserName:self.UsrNameTextField.text];
                    
                    NSString * userID = [[obj elementForName:@"uid"] stringValue];
                    [UserInfo setLoggedUserID:userID];
                    NSString *isVIP = [[obj elementForName:@"vipStatus"] stringValue];
                    if ([isVIP isEqualToString:@"1"]) {
                        [UserInfo setIsVIP:YES];
                        [UserInfo setVIPExpireTime:[[[obj elementForName:@"expireTime"] stringValue] doubleValue]];
                    }
                    else{
                        [UserInfo setIsVIP:NO];
                        [UserInfo setVIPExpireTime:0.0];
                    }
//                    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kLoggedUserID];
                    if (RemPasswordBtn.selected) {
                        //                        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:self.UsrNameTextField.text accessGroup:nil];
                        //                        [keychain setObject:self.PassWordTextField.text forKey:kPasswordKey];
                        [SFHFKeychainUtils storeUsername:self.UsrNameTextField.text andPassword:self.PassWordTextField.text forServiceName:kMyAppService updateExisting:YES error:nil];
                    }
                    HUD = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:HUD];
                    
                    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
                    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
                    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                    
                    // Set custom view mode
                    HUD.mode = MBProgressHUDModeCustomView;
                    
                    HUD.delegate = self;
                    HUD.labelText = @"登录成功";
                    
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
//                    self.CurrentUsrLabel.text = self.UsrNameTextField.text;
                    [self LoginViewWillAppear:self.UsrNameTextField.text];
                    self.LoginView.hidden = YES;
                    self.LogoutView.hidden = NO;
                    
                }else if([result isEqualToString:@"103"] || [result isEqualToString:@"102"] || [result isEqualToString:@"105"])
                {
                    NSString *msg = @"用户名或密码错误" ;
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                }
                else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                }
            }
        }
    }
}

#pragma mark -
#pragma MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self popMyself];
}
@end
