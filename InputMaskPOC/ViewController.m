//
//  ViewController.m
//  InputMaskPOC
//
//  Created by Douglas Nunes Alves on 4/7/15.
//  Copyright (c) 2015 Douglas Nunes Alves. All rights reserved.
//

#import "ViewController.h"
#import "MaskFormatter.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField* maskTextField;
@property (weak, nonatomic) IBOutlet UITextField* resultTextField;

@property (strong, nonatomic) MaskFormatter* maskFormatter;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultTextField.delegate = self;
}
- (IBAction)onClickChangeMask:(id)sender
{
    self.resultTextField.text = @"";
    self.maskFormatter = [[MaskFormatter alloc] initWithInputMask:self.maskTextField.text];
}

- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string
{
    
    NSString* value = [self.maskFormatter createMaskedStringFromValue:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    
    if (value) {
        textField.text = value;
    }

    return NO;
}
@end
