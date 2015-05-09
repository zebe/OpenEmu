/*
 Copyright (c) 2015, OpenEmu Team

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the OpenEmu Team nor the
       names of its contributors may be used to endorse or promote products
       derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY OpenEmu Team ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL OpenEmu Team BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "OEEditSmartCollectionWindowController.h"

#import "OEDBSmartCollection.h"

@interface OEEditSmartCollectionWindowController ()
@end

@implementation OEEditSmartCollectionWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self _setupRuleEditor];
}

- (void)_setupRuleEditor
{
    [[self editor] setRowHeight:25.0];
    [[self editor] setNestingMode:NSRuleEditorNestingModeList];
    [[self editor] setCanRemoveAllRows:NO];
}

- (NSString*)windowNibName {
    return @"OEEditSmartCollectionWindowController";
}

- (void)setCollection:(OEDBSmartCollection *)collection
{
    _collection = collection;

    NSRange fullRange = NSMakeRange(0, [[self editor] numberOfRows]);
    NSIndexSet *allIndexes = [NSIndexSet indexSetWithIndexesInRange:fullRange];
    [[self editor] removeRowsAtIndexes:allIndexes includeSubrows:YES];

    NSString *title = [collection name] ?: NSLocalizedString(@"Smart Collection", @"Edit Smart collection window default title");
    [[self window] setTitle:title];

    BOOL   hasFetchLimit = [collection fetchLimit] != 0;
    NSInteger fetchLimit = [collection fetchLimit] ?: 25;

    [[self limitToAmountField] setStringValue:[NSString stringWithFormat:@"%ld", fetchLimit]];
    [[self enableLimitButton] setState:hasFetchLimit];

    BOOL doesLiveUpdates = !collection || NO; // TOOD: get live updates from collection
    [[self liveUpdateButton] setState:doesLiveUpdates];

    NSPredicate *predicate = [collection fetchPredicate];
    if([predicate isKindOfClass:[NSCompoundPredicate class]]) {
        NSCompoundPredicate *compoundPredicate = (NSCompoundPredicate*)predicate;
        BOOL isORPredicate = [compoundPredicate compoundPredicateType] == NSOrPredicateType;
        [[self matchingBehaviourButton] selectItemAtIndex: isORPredicate ? 1 : 0];

    } else {
        [[self editor] addRow:self];
    }
}

#pragma mark - Getting the result
- (NSPredicate*)predicate
{
    BOOL isORPredicate = [[self matchingBehaviourButton] indexOfSelectedItem] == 1;
    NSPredicate *pred = [[self editor] predicate];
    NSArray *subpredicates = @[pred];
    if([pred isKindOfClass:[NSCompoundPredicate class]]){
        subpredicates = [(NSCompoundPredicate*)pred subpredicates];
    }

    if(isORPredicate)
        return [NSCompoundPredicate orPredicateWithSubpredicates:subpredicates];
    else
        return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

- (BOOL)hasFetchLimit
{
    return [[self enableLimitButton] state];
}

- (NSInteger)fetchLimit
{
    return [[self limitToAmountField] integerValue];
}

#pragma mark -
- (IBAction)generalConfigurationChanged:(id)sender
{

}


/* -- Optional delegate methods -- */


/* When called, you should return an NSDictionary representing the parts of the predicate determined by the given criterion and value.  The keys of the dictionary should be the strings shown above that begin with NSRuleEditorPredicate..., and the values should be as described in the comments adjacent to the keys.  Implementation of this method is optional.
- (NSDictionary *)ruleEditor:(NSRuleEditor *)editor predicatePartsForCriterion:(id)criterion withDisplayValue:(id)value inRow:(NSInteger)row
{}
*/
#pragma mark - Modal Controls
- (IBAction)cancelChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseCancel];
    [[self window] close];
}

- (IBAction)confirmChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseOK];
    [[self window] close];
}
@end
