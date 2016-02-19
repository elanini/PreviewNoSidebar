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
//we need this here so we can call it
//would use performSelector:withObject:withObject but BOOL isnt an object
//alternative would be NSInvocation
- (void)closeSidebarWithAnimation:(BOOL)arg1 completionHandler:(CDUnknownBlockType)arg2
{
    ZKOrig(void, arg2, arg2);
}

//openSidebarWithAnimation is called from windowDidLoad
//I just undo what it did already, closing the sidebar if there is only one page open in
//the window and it is a PDF
- (void)windowDidLoad
{
    ZKOrig(void);
    id arrayIvar = ZKHookIvar(self, id, "_containersArrayController");
    if ([arrayIvar class] == NSClassFromString(@"NSArrayController")) {;
        NSArray *array = [(NSArrayController*)arrayIvar arrangedObjects];
        if ([array count] == 1 &&
            [[array  firstObject] class] == NSClassFromString(@"PVPDFPageContainer")) {
            [self closeSidebarWithAnimation:NO completionHandler:nil];
        }
    }
}


@end