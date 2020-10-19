#import <Foundation/Foundation.h>

static NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
static bool isBigSur = version.majorVersion == 11 || (version.majorVersion == 10 && version.minorVersion > 15);

bool getDoNotDisturbBigSur() {
  bool doNotDisturb = [[[[NSUserDefaults alloc] initWithSuiteName:@"com.apple.notificationcenterui"] objectForKey:@"doNotDisturb"] boolValue];
  NSCAssert(isBigSur, @"must be on big sur");
  return doNotDisturb;
}

bool getDoNotDisturbOlderThanBigSur() {
  bool doNotDisturb = doNotDisturb = [[[[NSUserDefaults alloc] initWithSuiteName:@"com.apple.controlcenter"] objectForKey:@"NSStatusItem Visible DoNotDisturb"] boolValue];
  NSCAssert(isBigSur, @"must not be on big sur");
  return doNotDisturb;
}

bool getDoNotDisturb() {
  if (!isBigSur) {
    return getDoNotDisturbOlderThanBigSur();
  } else {
    return getDoNotDisturbBigSur();
  }
}
