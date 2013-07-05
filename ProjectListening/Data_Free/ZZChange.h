//
//  ZZChange.h
//  ProjectListening
//
//  Created by zhaozilong on 13-5-5.
//
//

#ifndef ProjectListening_ZZChange_h
#define ProjectListening_ZZChange_h

//TestType
#define TEST_TYPE 102
#define IS_PRO_Ver NO

#define DB_NAME_ZZAIDB @"ZZAIdb.sqlite"
#define DB_NAME_WORDS @"WORDS.sqlite"
#define DB_NAME_ASSISTANT @"Assistant.sqlite"
#define DB_NAME_TEXT_ANSWER @"ToeflListening.sqlite3"

#define PLIST_NAME_PROGRESS @"Progress.plist"
#define PLIST_NAME_PRODUCTS @"Products.plist"
#define PLIST_NAME_USERADVISE @"UserAdvise.plist"
#define PLIST_NAME_ASSISTANT @"Assistant.plist"
#define PLIST_NAME_STUDYTIME @"StudyTime.plist"

//软件版本号
//1.0.0发布的第一版
//1.0.1修改了一些小Bug
//1.1.0此版本更新后，把题目全部解锁了，需要把PackInfo中的IsVip都修改成YES
#define kApplicationVersion @"Ver_1.1.0"

#define AUDIO_SUFFIX @".m4a"
#define TEMP_AUDIO_SUFFIX @".m4a"

#define DefaultRealFontSize (IS_IPAD ? 26 : 16)
//日语和中文还有英文的字体需要区分
/*
 *日语：HiraKakuProN-W3
 *日语加粗：HiraKakuProN-W6
 *
 *英语：HelveticaNeue
 *英语加粗：HelveticaNeue-Bold
 *
 *中文：HelveticaNeue
 *中文加粗：HelveticaNeue-Bold
 */
#define FONT_NAME_BOLD @"HelveticaNeue-Bold"
#define FONT_NAME @"HelveticaNeue"

//http://static2.iyuba.com/sounds/toeic/1/01.mp3
#define AUDIO_DOWNLOAD_URL @"http://static.iyuba.com/sounds/toefl/"

#define APP_NAME @"toefl"
#define APP_ID @"642077630"
#define FLURRY_ID @"NVQBFY48PMKMYBPCQ43W"
#define ADMOB_ID @"a151beca321de4b"
#define PID_VIP_MODE @"com.iyuba.ToeflListening.VIP"


#endif
