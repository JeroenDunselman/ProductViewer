//
//  ViewController.h
//  Neocles
//
//  Created by Jeroen Dunselman on 07/06/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) NSString *token;
@end

