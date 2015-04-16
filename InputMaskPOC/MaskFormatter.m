//
//  MaskFormatter.m
//  InputMaskPOC
//
//  Created by Douglas Alves on 4/15/15.
//  Copyright (c) 2015 Douglas Nunes Alves. All rights reserved.
//

#import "MaskFormatter.h"
#import "MaskTranslation.h"

@interface MaskFormatter ()

@property (nonatomic, strong) NSMutableDictionary* maskTranslations;

@end

@implementation MaskFormatter

- (id)initWithInputMask:(NSString*)inputMask {
    self = [super init];
    
    if (self) {
        self.inputMask = inputMask;
    }
    return self;
}

// Creates a masked string applying the inputMask defined to the value passed as parameter.
// If the 'value' can't be masked, return nil;
- (NSString*)createMaskedStringFromValue:(NSString*)value
{
    NSMutableString* textWithMask = [NSMutableString string];
    int maskIndex = 0;
    int valueIndex = 0;
    
    while (valueIndex < value.length && maskIndex < self.inputMask.length) {
        unichar valueChar = [value characterAtIndex:valueIndex];
        unichar maskChar = [self.inputMask characterAtIndex:maskIndex];
        MaskTranslation* translation = [self.maskTranslations objectForKey:[NSString stringWithFormat:@"%c", maskChar]];
        if (translation) {
            if ([self isCharacter:valueChar allowedByMask:maskChar]) {
                // Match the pattern. Append.
                [textWithMask appendString:[NSString stringWithFormat:@"%c", valueChar]];
                maskIndex++;
                valueIndex++;
            } else {
                // Doesn't match the pattern
                if (translation.optional) {
                    maskIndex++;
                } else {
                    // Not optional, can't continue
                    return nil;
                }
            }
        } else {
            if (valueChar == maskChar) {
                // The character typed is the same as the one in the mask. Insert it and go to the next mask and value character.
                [textWithMask appendString:[NSString stringWithFormat:@"%c", valueChar]];
                maskIndex++;
                valueIndex++;
            } else {
                // It's part of the mask. Insert it and go to the next character of the mask
                [textWithMask appendString:[NSString stringWithFormat:@"%c", maskChar]];
                maskIndex++;
            }
        }
        
    }
    
    // Check if the final text is longer than the mask or if there are some characters that weren't evaluated.
    if (textWithMask.length > self.inputMask.length || valueIndex < value.length) {
        return nil;
    }
    
    return textWithMask;
}

// Check if the character is allowed by the mask. It checks it agains the regex pattern defined
// for that translation.
- (BOOL)isCharacter:(unichar)character allowedByMask:(unichar)mask
{
    
    NSString* pattern = nil;
    MaskTranslation* maskTranslation = [self.maskTranslations objectForKey:[NSString stringWithFormat:@"%c", mask]];
    if (maskTranslation)
    {
        pattern = maskTranslation.translation;
    }
    
    if (pattern)
    {
        NSString* characterString = [NSString stringWithFormat:@"%c", character];
        
        NSPredicate* stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        return [stringTest evaluateWithObject:characterString];
    }
    
    return NO;
}

- (NSString*) inputMask
{
    // Lazy instantiation
    if (!_inputMask) {
        _inputMask = [NSString string];
    }
    return _inputMask;
}

- (NSMutableDictionary*) maskTranslations
{
    // Lazy instantiation
    if (!_maskTranslations) {
        _maskTranslations = [MaskFormatter loadDefaultTranslations];
    }
    return _maskTranslations;
}

// Load the default translations. New translations can be added in the future.
+ (NSMutableDictionary*)loadDefaultTranslations
{
    
    NSMutableDictionary* translations = [[NSMutableDictionary alloc] init];
    
    [translations setObject:[MaskTranslation initWithTranslation:@"\\d" isOptional:false] forKey:@"0"];
    [translations setObject:[MaskTranslation initWithTranslation:@"\\d" isOptional:true] forKey:@"9"];
    [translations setObject:[MaskTranslation initWithTranslation:@"[a-zA-Z0-9]" isOptional:false] forKey:@"A"];
    [translations setObject:[MaskTranslation initWithTranslation:@"[a-zA-Z0-9]" isOptional:true] forKey:@"a"];
    [translations setObject:[MaskTranslation initWithTranslation:@"[a-zA-Z]" isOptional:false] forKey:@"S"];
    [translations setObject:[MaskTranslation initWithTranslation:@"[a-z]" isOptional:false] forKey:@"L"];
    [translations setObject:[MaskTranslation initWithTranslation:@"[A-Z]" isOptional:false] forKey:@"U"];
    
    return translations;
}



@end
