//
//  Defines.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#define FORCELANDSCAPE NO




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


//datetime specs

#define DEFAULT_DATE_UTILS_TIMESTAMP_FORMAT @"yyyy-MM-dd HH:mm:ss"

#define DEFAULT_DATE_UTILS_DATE_FORMAT @"yyyy-MM-dd"

#define DEFAULT_DATE_UTILS_OUT_TIMESTAMP_FORMAT @"EEE MMM d, yyyy HH:mm"


#define DEFAULT_DATE_UTILS_OUT_DATE_FORMAT @"EEE MMM d, yyyy"


#define ENDPOINT @"https://gist.github.com/anonymous/4680060/raw/aac6d818e7103edfe721e719b1512f707bcfb478/sample.json"

