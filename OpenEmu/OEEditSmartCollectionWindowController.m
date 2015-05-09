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

#pragma mark -
- (IBAction)generalConfigurationChanged:(id)sender
{

}

#pragma mark - Modal Controls
- (IBAction)cancelChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseOK];
}

- (IBAction)confirmChanges:(id)sender
{
    [NSApp stopModalWithCode:NSModalResponseOK];
}
@end
