//
//  TicketViewController.h
//  ToeflListeningPro
//
//  Created by zhaozilong on 13-6-24.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TicketViewController : UIViewController {
//    MBProgressHUD * HUD;
}

@property (nonatomic, retain) MBProgressHUD * HUD;
@property (retain, nonatomic) IBOutlet UIButton *ticketBtn;
- (IBAction)ticketBtnPressed:(id)sender;

@end
