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
                                 @"timestamp": logMessage->_timestamp,
                                 @"log-level": @(logMessage->_level),
                                 };

    return logPayload;
}

#pragma mark - DDLogger

- (void)logMessage:(DDLogMessage *)logMessage
{
    NSString *logString = logMessage->_message;

    if (self->_logFormatter) {
        logString = [self->_logFormatter formatLogMessage:logMessage];
    }

    if (logString) {
        NSDictionary *extraLogPayload = [self extraLogPayloadFromLogMessage:logMessage];
        NSMutableDictionary *logPayload = [NSMutableDictionary dictionaryWithDictionary:extraLogPayload];
        logPayload[@"message"] = logString;

        [self.antenna log:logPayload];
    }
}

@end
