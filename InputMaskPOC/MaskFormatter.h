//
//  MaskFormatter.h
//  InputMaskPOC
//
//  Created by Douglas Alves on 4/15/15.
//  Copyright (c) 2015 Douglas Nunes Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskFormatter : NSObject

@property (nonatomic, strong) NSString* inputMask;

- (id)initWithInputMask:(NSString*)inputMask;

- (NSString*)createMaskedStringFromValue:(NSString*)value;

@end
