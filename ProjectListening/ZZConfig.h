//
//  ZZConfig.h
//  ProjectListening
//
//  Created by zhaozilong on 13-3-6.
//
//

#ifndef ProjectListening_ZZConfig_h
#define ProjectListening_ZZConfig_h

//判断设备是IPHONE还是IPAD
#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE_568H [[UIScreen mainScreen] bounds].size.height == 568.000000

//Separated
#define SEPARATE_SYMBOL @"++"

//bool
#define ASSISTANT_IS_FIRST_TIME_ARRANGEMENT @"is_first_time_arrangement"

//data
#define ASSISTANT_MOST_LATE_TIME @"most_late_time"
#define ASSISTANT_MOST_EARLY_TIME @"most_early_time"
#define ASSISTANT_LAST_NOW_INTERVAL_DAYS @"last_now_interval_days"
//#define ASSISTANT_PURCHASE_NUM @"purchase_num"
#define ASSISTANT_LAST_OPEN_DATE @"last_open_date"
#define ASSISTANT_FIRST_OPEN_DATE @"first_open_date"

#endif
