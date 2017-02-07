//
//  main.m
//  RBRefresh
//
//  Created by 夏敏 on 06/02/2017.
//  Copyright © 2017 夏敏. All rights reserved.
//

#import <Foundation/Foundation.h>

// From here to end of file added by Injection Plugin //

#ifdef DEBUG
#define INJECTION_PORT 31452
static char _inMainFilePath[] = __FILE__;
static const char *_inIPAddresses[] = {"192.168.101.11", "192.168.2.1", "169.254.176.46", "127.0.0.1", 0};

#define INJECTION_ENABLED
#import "/tmp/injectionforxcode/BundleInjection.h"
#endif

// Remote Plugin patch start //

#ifdef DEBUG
#define REMOTE_PORT 31459
#include "/Applications/Injection.app/Contents/Resources/RemoteCapture.h"
#define REMOTEPLUGIN_SERVERIPS "192.168.101.11 169.254.176.46 192.168.2.1"
@implementation RemoteCapture(Startup)
+ (void)load {
    [self performSelectorInBackground:@selector(startCapture:) withObject:@REMOTEPLUGIN_SERVERIPS];
}
@end
#endif

// Remote Plugin patch end //
