#import "EmasManager.h"
#import "Emas.h"
#pragma mark - Emas
@interface Emas()

@end
@implementation Emas
static SDK *sdk = nil;
static EmasManager *manager = nil;

+(instancetype)Instance {
    return sdk;
}

- (void) pluginInitialize
{
    NSLog(@"Emas->%@", @"init");
    
    sdk = self;
    manager = [[EmasManager alloc]init];
    [manager initManService];
}
@end
