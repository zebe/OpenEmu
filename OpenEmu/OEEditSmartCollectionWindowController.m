//
//  OEEditSmartCollectionWindowController.m
//  OpenEmu
//
//  Created by Christoph Leimbrock on 5/9/15.
//
//

#import "OEEditSmartCollectionWindowController.h"

#import "OEDBSmartCollection.h"

@interface OEEditSmartCollectionWindowController ()

@end

@implementation OEEditSmartCollectionWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (NSString*)windowNibName {
    return @"OEEditSmartCollectionWindowController";
}

- (void)setCollection:(OEDBSmartCollection *)collection
{
    _collection = collection;

    NSString *title = [collection name] ?: NSLocalizedString(@"Smart Collection", @"Edit Smart collection window default title");
    [[self window] setTitle:title];
}

#pragma mar -
- (IBAction)cancelChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseOK];
}

- (IBAction)confirmChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseOK];
}
@end
