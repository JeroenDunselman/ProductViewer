//
//  ViewController.m
//  Neocles
//
//  Created by Jeroen Dunselman on 07/06/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize loginText, passwordText;



- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  //Get stored token
  self.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
  if (self.token == nil) {
    [self getAccesToken];
  }
  
  if (self.token != nil) {
    //get account ID with token
    NSString *urlAsString = [NSString stringWithFormat:@"https://epicuroapitest.azurewebsites.net/api/accounts/?i=%@", self.token];
    //
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
      if (error) {
        NSLog(@"Error: %@", error);
      } else {
        NSDictionary *theDct = responseObject;
      }
    }];
    [dataTask resume];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) getAccesToken {
  NSString *userName = @"test@neocles.io";
  NSString *passWord = @"neoclestest";
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSDictionary *params = @{@"grant_type": @"password",
                           @"username": userName,
                           @"password": passWord};
  
  [manager POST:@"https://epicuroapitest.azurewebsites.net/token" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    
    NSString *result = [responseObject objectForKey:@"access_token"];
    NSLog(@"%@", result);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:result
                     forKey:@"access_token"];
    [userDefaults synchronize];
    self.token = result;
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
  }];
}

- (IBAction)loginButton:(id)sender {
  
}
@end
