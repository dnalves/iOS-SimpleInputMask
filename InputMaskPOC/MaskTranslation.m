//
//  MaskTranslation.m
//  InputMaskPOC
//
//  Created by Douglas Nunes Alves on 4/8/15.
//  Copyright (c) 2015 Douglas Nunes Alves. All rights reserved.
//

#import "MaskTranslation.h"

@implementation MaskTranslation

+ (id)initWithTranslation:(NSString*)translation isOptional:(BOOL)optional {
    MaskTranslation* maskTranslation = [[MaskTranslation alloc] init];
    if (maskTranslation) {
        maskTranslation.translation = [NSString stringWithString:translation];
        maskTranslation.optional = optional;
    }
    
    return maskTranslation;
}

@end
