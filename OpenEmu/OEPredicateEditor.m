//
//  OEPredicateEditor.m
//  OpenEmu
//
//  Created by Christoph Leimbrock on 5/10/15.
//
//

#import "OEPredicateEditor.h"

@interface OEPredicateEditor ()
@property (nonatomic, strong) NSString *themeKey;
@end
@implementation OEPredicateEditor

- (id)_backgroundColors
{
    return @[[self _colorForThemeKeySuffix:@"background"]];
}

- (id)_sliceTopBorderColor
{
    return [self _colorForThemeKeySuffix:@"slice_top"];
}

- (id)_sliceBottomBorderColor
{
    return [self _colorForThemeKeySuffix:@"slice_bottom"];
}

- (id)_sliceLastBottomBorderColor
{
    return [self _colorForThemeKeySuffix:@"slice_bottom_last"];
}

- (NSColor*)_colorForThemeKeySuffix:(NSString*)suffix
{
    NSString *key = [_themeKey stringByAppendingFormat:@"_%@", suffix];
    return [self _colorForKey:key];
}

- (NSColor*)_colorForKey:(NSString*)key;
{
    OEThemeState state = OEThemeStateDefault;
    return [[OETheme sharedTheme] colorForKey:key forState:state];
}
#pragma mark - OEControl
- (void)setThemeKey:(NSString *)key
{
    _themeKey = key;
}

- (void)setBackgroundThemeImageKey:(NSString *)key
{}

- (void)setThemeImageKey:(NSString *)key
{}

- (void)setThemeTextAttributesKey:(NSString *)key
{}

- (BOOL)isTrackingModifierActivity
{
    return NO;
}

- (BOOL)isTrackingMouseActivity
{
    return NO;
}

- (BOOL)isTrackingWindowActivity
{
    return NO;
}

@end
