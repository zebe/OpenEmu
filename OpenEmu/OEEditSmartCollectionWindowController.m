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
#import "OERuleEditorCriterion.h"

@interface OEEditSmartCollectionWindowController ()
@property NSMutableArray *criteria;
@end

@implementation OEEditSmartCollectionWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];

    [self _setupCriteria];
    [self _setupRuleEditor];
}

- (void)_setupCriteria
{
    #define Criterion(_NAME_, _CHILDREN_) [OERuleEditorCriterion criterionWithName:_NAME_ children:_CHILDREN_]
    _criteria = [@[
                   Criterion(@"Test Criterion", nil)
                   ] mutableCopy];
}

- (void)_setupRuleEditor
{
    [[self ruleEditor] setRowHeight:25.0];
    [[self ruleEditor] setNestingMode:NSRuleEditorNestingModeList];
    [[self ruleEditor] setCanRemoveAllRows:NO];
    [[self ruleEditor] addRow:nil];
}

- (NSString*)windowNibName {
    return @"OEEditSmartCollectionWindowController";
}

- (void)setCollection:(OEDBSmartCollection *)collection
{
    _collection = collection;

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

        NSArray *subpredicates = [compoundPredicate subpredicates];

    }
}

#pragma mark -
- (IBAction)generalConfigurationChanged:(id)sender
{

}

#pragma mark - Rule Editor Delegate
- (NSInteger)ruleEditor:(NSRuleEditor *)editor numberOfChildrenForCriterion:(id)criterion withRowType:(NSRuleEditorRowType)rowType
{
    if(criterion == nil)
        return [_criteria count];

    return [[criterion children] count];
}

- (id)ruleEditor:(NSRuleEditor *)editor child:(NSInteger)index forCriterion:(id)criterion withRowType:(NSRuleEditorRowType)rowType
{
    if(criterion == nil)
        return [_criteria objectAtIndex:index];

    return [[criterion children] objectAtIndex:index];
}

- (id)ruleEditor:(NSRuleEditor *)editor displayValueForCriterion:(id)criterion inRow:(NSInteger)row
{
    return [criterion displayValue];
}

/* -- Optional delegate methods -- */


/* When called, you should return an NSDictionary representing the parts of the predicate determined by the given criterion and value.  The keys of the dictionary should be the strings shown above that begin with NSRuleEditorPredicate..., and the values should be as described in the comments adjacent to the keys.  Implementation of this method is optional.
- (NSDictionary *)ruleEditor:(NSRuleEditor *)editor predicatePartsForCriterion:(id)criterion withDisplayValue:(id)value inRow:(NSInteger)row
{}

/* If ruleEditorRowsDidChange: is implemented, NSRuleEditor will automatically register its delegate to receive NSRuleEditorRowsDidChangeNotification notifications to this method. Implementation of this method is optional.
- (void)ruleEditorRowsDidChange:(NSNotification *)notification
{}
//*/

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
