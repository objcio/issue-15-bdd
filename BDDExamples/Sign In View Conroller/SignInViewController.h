//
//  Copyright (c) 2014 Pawel Dudek. All rights reserved.
//


#import <Foundation/Foundation.h>

@class SignInManager;

@interface SignInViewController : UIViewController

@property(nonatomic, readwrite) IBOutlet UIButton *signInButton;

@property(nonatomic, readwrite) IBOutlet UITextField *usernameTextField;
@property(nonatomic, readwrite) IBOutlet UITextField *passwordTextField;

@property(nonatomic, readwrite) IBOutlet UILabel *fillInBothFieldsLabel;

@property(nonatomic, readonly) SignInManager *signInManager;

- (instancetype)initWithSignInManager:(SignInManager *)signInManager;

- (IBAction)didTapSignInButton:(UIButton *)signInButton;

@end
