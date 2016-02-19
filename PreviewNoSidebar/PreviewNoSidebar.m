//
//  PreviewNoSidebar.m
//  PreviewNoSidebar
//
//  Created by Eric Lanini on 2/18/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Opee/Opee.h>

typedef void (^CDUnknownBlockType)(void);

@interface PVWindowController : NSObject
- (void)windowDidLoad;
- (void)closeSidebarWithAnimation:(BOOL)arg1 completionHandler:(CDUnknownBlockType)arg2;
@end

ZKSwizzleInterface($_Replacement, PVWindowController, NSObject);

@implementation $_Replacement
- (void)closeSidebarWithAnimation:(BOOL)arg1 completionHandler:(CDUnknownBlockType)arg2
{
    ZKOrig(void, arg2, arg2);
}


- (void)windowDidLoad
{
    ZKOrig(void);
    NSArray *array = [ZKHookIvar(self, NSArrayController*, "_containersArrayController") arrangedObjects];
    if (    [array count] == 1
        && [[array  firstObject] class] == NSClassFromString(@"PVPDFPageContainer")) {
        [self closeSidebarWithAnimation:NO completionHandler:nil];
    }
}


@end