//
//  OEPredicateEditor.h
//  OpenEmu
//
//  Created by Christoph Leimbrock on 5/10/15.
//
//

#import <Cocoa/Cocoa.h>

#import "OEControl.h"
@interface OEPredicateEditor : NSPredicateEditor <OEControl>

@property(nonatomic, retain) OEThemeImage          *backgroundThemeImage;
@property(nonatomic, retain) OEThemeImage          *themeImage;
@property(nonatomic, retain) OEThemeTextAttributes *themeTextAttributes;

@property(nonatomic, readonly, getter = isTrackingWindowActivity)    BOOL trackWindowActivity;
@property(nonatomic, readonly, getter = isTrackingMouseActivity)     BOOL trackMouseActivity;
@end
