#import "AppDelegate.h"

// CocoaLumberjack
#import <DDLog.h>
#import <DDASLLogger.h>
#import <DDTTYLogger.h>
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

// Antenna
#import <Antenna.h>

// CocoaLumberjack + Antenna
#import "DDAntennaLogger.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Antenna setup
    [[Antenna sharedLogger] addChannelWithURL:[NSURL URLWithString:@"http://example.com"] method:@"LOG"];
    [[Antenna sharedLogger] startLoggingApplicationLifecycleNotifications];

    // CocoaLumberjack setup
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // Antenna-CocoaLumberjack setup
    DDAntennaLogger *logger = [[DDAntennaLogger alloc] initWithAntenna:[Antenna sharedLogger]];
    [DDLog addLogger:logger];

    DDLogInfo(@"DDAntennaLogger is cool!");

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
