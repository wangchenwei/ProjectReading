//
//  FirstView.h
//  ProjectListening
//
//  Created by zhaozilong on 13-4-20.
//
//

#import <UIKit/UIKit.h>

@interface FirstView : UIView
@property (retain, nonatomic) IBOutlet UIButton *assKenBtn;
@property (retain, nonatomic) IBOutlet UIButton *assKateBtn;
@property (retain, nonatomic) IBOutlet UILabel *xiaotaoLabel;
@property (retain, nonatomic) IBOutlet UILabel *dayeLabel;

- (IBAction)KenBtnPressed:(id)sender;
- (IBAction)KateBtnPressed:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *timeOneBtn;
@property (retain, nonatomic) IBOutlet UIButton *timeTwoBtn;
@property (retain, nonatomic) IBOutlet UIButton *timeThreeBtn;
@property (retain, nonatomic) IBOutlet UIView *ENHView;
@property (retain, nonatomic) IBOutlet UILabel *easyLabel;
@property (retain, nonatomic) IBOutlet UILabel *normalLabel;
@property (retain, nonatomic) IBOutlet UILabel *hardLabel;

- (IBAction)timeOneBtnPressed:(id)sender;
- (IBAction)timeTwoBtnPressed:(id)sender;
- (IBAction)timeThreeBtnPressed:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)startBtnPressed:(id)sender;

@end
