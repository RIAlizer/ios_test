//
//  Defines.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#define FORCELANDSCAPE NO



#define NAMESPACE @"nttdata.exception"
#define ERROR_DOMAIN @"nttdata.error"
#define EXCEPTION_VTRESOURCE_NOT_LOADED @"nttdata.exception.resourceNotLoaded" 
#define AES_CRIPTO_KEY @"aes_cripto_key"

#define BNL_THEME_GREEN 0x009966
#define BNL_THEME_DARK_GREEN 0x009966



//override UIView + Shadow defs
#define DEFAULT_SHADOW_OFFSET CGSizeMake(0.0f, -3.0f)

#define DEFAULT_SHADOW_RADIUS 3.0f

#define DEFAULT_SHADOW_OPACITY 0.7f

#define DEFAULT_SHADOW_COLOR [UIColor blackColor].CGColor

#define DEFAULT_FADE_IN_TIMEOUT 1.0f

#define DEFAULT_FADE_OUT_TIMEOUT 1.0f

#define DEFAULT_PUSH_FADE_IN_TIMEOUT 0.4f

#define DEFAULT_PUSH_FADE_OUT_TIMEOUT 0.4f


#define FAKE_TIMEOUT 2 //seconds


//MACROS defined in Target Settings

//enable DEBUG info
#ifndef DEBUG
    #define DEBUG 1
#endif

//enable PRODUCTION endpoint
#ifndef PRODUCTION
    #define PRODUCTION 0
#endif

//enable ENABLE_DEBUG_MEM, add Stats Component to AppDelegate
#ifndef ENABLE_DEBUG_MEM
    #define ENABLE_DEBUG_MEM 1
#endif

//enable ENABLE_LOCALIZATION, enable LSTR conversion
#ifndef ENABLE_LOCALIZATION
    #define ENABLE_LOCALIZATION 1
#endif

//enable LOGGING_ENABLED, enable Logging Behavior
#ifndef LOGGING_ENABLED
    #define LOGGING_ENABLED 1
#endif

//enable ENABLE_FILE_ENCRYPTION, enable File Encryption AES
#ifndef ENABLE_FILE_ENCRYPTION
    #define ENABLE_FILE_ENCRYPTION 1
#endif

//enable ENABLE_FAKE_REMOTING, enable sleep(FAKE_TIMEOUT), useful to simulate web request
#ifndef ENABLE_FAKE_REMOTING
    #define ENABLE_FAKE_REMOTING 1
#endif

//enable NULLSAFE_ENABLED , macro to easily enable/disable per scheme behavior NullSafe.h
#ifndef NULLSAFE_ENABLED
    #define NULLSAFE_ENABLED 1
#endif


//font embedding
#define DEFAULT_APP_FONT                @"PT-sans-regular.ttf"
#define DEFAULT_APP_FONT_BOLD           @"PT-sans-bold.ttf"
#define DEFAULT_APP_FONT_ITALIC         @"PT-sans-italic.ttf"
#define DEFAULT_APP_FONT_BOLD_ITALIC    @"PT-sans-bold-italic.ttf"

//iVersion specs
#define REMOTE_VERSIONS_PLIST_URL @"http://lab.joinpad.net/rializer/ilib/latest/appVersions.plist"//@"http://rializer.com/ios/nttdata/ilibrary/latest/appVersions.plist"
#define UPDATE_URL @"http://lab.joinpad.net/rializer/ilib/latest"//@"http://rializer.com/ios/nttdata/ilibrary/latest/"

//service endpoint
#define TEST_BASE_URL @"http://rializer.com/ios/nttdata/ilibrary"
//#define TEST_BASE_URL @"http://gonte-macbook-pro.local"

//#define TEST_LIST_PRESENTATION @"/test/sampledocs/ilib/listpresentation.php"
#define TEST_LIST_PRESENTATION @"http://lab.joinpad.net/rializer/ilib/repo/listpresentation.php"//@"http://lab.joinpad.net/rializer/ilib/repo/listpresentation.php"
//#define TEST_DETAIL_PRESENTATION @"/test/sampledocs/ilib/sample2.ilb"
#define TEST_DETAIL_PRESENTATION @"/test/sampledocs/ilib/sample2.ilb"

//datetime specs

#define DEFAULT_DATE_UTILS_TIMESTAMP_FORMAT @"yyyy-MM-dd HH:mm:ss"

#define DEFAULT_DATE_UTILS_DATE_FORMAT @"yyyy-MM-dd"

#define DEFAULT_DATE_UTILS_OUT_TIMESTAMP_FORMAT @"EEE MMM d, yyyy HH:mm"


#define DEFAULT_DATE_UTILS_OUT_DATE_FORMAT @"EEE MMM d, yyyy"


#define ENDPOINT @"https://gist.github.com/anonymous/4680060/raw/aac6d818e7103edfe721e719b1512f707bcfb478/sample.json"

