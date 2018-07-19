#import <CloudPushSDK/CloudPushSDK.h>
#import <AlicloudMobileAnalitics/ALBBMAN.h>
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import <CrashReporter/CrashReport.h>

@interface EmasManager()

@end
@implementation EmasManager

- (instancetype)init{
  self = [super init];
  return self
}

- (void)initManService{

  ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
  [man autoInit];

  // YWFeedbackKit *feedbackKit = [[YWFeedbackKit alloc] autoInit];

  PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
  NSError *error;
  // Check if we previously crashed
  if ([crashReporter hasPendingCrashReport])
    [self handleCrashReport];
    
  // Enable the Crash Reporter
  if (![crashReporter enableCrashReporterAndReturnError: &error])
    NSLog(@"Warning: Could not enable crash reporter: %@", error);
}

- (void) handleCrashReport {
  PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
  NSData *crashData;
  NSError *error;
   
  // Try loading the crash report
  crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
  if (crashData == nil) {
    NSLog(@"Could not load crash report: %@", error);
    goto finish;
  }
  // We could send the report from here, but we'll just print out
  // some debugging info instead
  PLCrashReport *report = [[[PLCrashReport alloc] initWithData: crashData error: &error] autorelease];
  if (report == nil) {
    NSLog(@"Could not parse crash report");
    goto finish;
  }
 
  NSLog(@"Crashed on %@", report.systemInfo.timestamp);
  NSLog(@"Crashed with signal %@ (code %@, address=0x%" PRIx64 ")", report.signalInfo.name,
          report.signalInfo.code, report.signalInfo.address);
  // Purge the report
  finish:
    [crashReporter purgePendingCrashReport];
    return;
}

-(void)initPushService{
  // [CloudPushSDK autoInit:^(CloudPushCallbackResult *res) {
  //   if (res.success) {
  //     NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
  //   } else {
  //     NSLog(@"Push SDK init failed, error: %@", res.error);
  //   }
  // }];
}