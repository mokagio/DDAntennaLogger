#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@class Antenna;

@interface DDAntennaLogger : DDAbstractLogger <DDLogger>

/**
 *  @discussion This is the designate initializer
 *
 *  @param antenna An Antenna logger
 *
 *  @return A configured logger that logs using the given Antenna
 */
- (id)initWithAntenna:(Antenna *)antenna;

/**
 *  A dictionary of values to add to the log message to the Antenna log.
 *  The keys are: "file", "method", "timestamp", "log-level"
 *  @discussion Subclass and override this method if you want to add extra parameter.
 *
 *  @param logMessage The `DDLogMessage` containg the data that's about to be logged
 *
 *  @return A dictionary of values to add to the log message to the Antenna log.
 */
- (NSDictionary *)extraLogPayloadFromLogMessage:(DDLogMessage *)logMessage;

@end
