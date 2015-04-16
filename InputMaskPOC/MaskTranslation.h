//
//  MaskTranslation.h
//  InputMaskPOC
//
//  Created by Douglas Nunes Alves on 4/8/15.
//  Copyright (c) 2015 Douglas Nunes Alves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskTranslation : NSObject

@property (nonatomic, strong) NSString* translation;
@property (nonatomic) BOOL optional;

+ (id)initWithTranslation:(NSString*)translation isOptional:(BOOL)optional;

@end
