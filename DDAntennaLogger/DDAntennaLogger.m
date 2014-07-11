#import "DDAntennaLogger.h"
#import <Antenna.h>

@interface DDAntennaLogger ()

@property (nonatomic, strong) Antenna *antenna;

@end

@implementation DDAntennaLogger

- (id)initWithAntenna:(Antenna *)antenna
{
    self = [super init];
    if (!self) { return nil; }

    self.antenna = antenna;

    return self;
}

- (id)init
{
    return [self initWithAntenna:[Antenna sharedLogger]];
}

#pragma mark - Log Payload

- (NSDictionary *)extraLogPayloadFromLogMessage:(DDLogMessage *)logMessage
{
    NSDictionary *logPayload = @{
                                 @"file": logMessage.fileName,
                                 @"method": logMessage.methodName,
                                 @"timestamp": logMessage->timestamp,
                                 @"log-level": @(logMessage->logLevel),
                                 };

    return logPayload;
}

#pragma mark - DDLogger

- (void)logMessage:(DDLogMessage *)logMessage
{
    NSString *logString = logMessage->logMsg;

    if (self->formatter) {
        logString = [self->formatter formatLogMessage:logMessage];
    }

    if (logString) {
        NSDictionary *extraLogPayload = [self extraLogPayloadFromLogMessage:logMessage];
        NSMutableDictionary *logPayload = [NSMutableDictionary dictionaryWithDictionary:extraLogPayload];
        logPayload[@"message"] = logString;

        [self.antenna log:logPayload];
    }
}

@end
