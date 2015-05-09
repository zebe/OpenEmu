//
//  OEEditSmartCollectionWindowController.h
//  OpenEmu
//
//  Created by Christoph Leimbrock on 5/9/15.
//
//

#import <Cocoa/Cocoa.h>

@class OEDBSmartCollection;
@interface OEEditSmartCollectionWindowController : NSWindowController
@property (strong, nonatomic) OEDBSmartCollection *collection;

#pragma mark - General
@property (assign) IBOutlet NSPopUpButton *matchingBehaviourButton;
@property (assign) IBOutlet NSRuleEditor  *ruleEditor;
@property (assign) IBOutlet NSButton      *enableLimitButton;
@property (assign) IBOutlet NSTextField   *limitToAmountField;
@property (assign) IBOutlet NSButton      *liveUpdateButton;

- (IBAction)generalConfigurationChanged:(id)sender;

#pragma mark - Modal Controls
@property (assign) IBOutlet NSButton *cancelButton, *confirmButton;
- (IBAction)cancelChanges:(id)sender;
- (IBAction)confirmChanges:(id)sender;
@end
