//
//  ProductTableViewController.m
//  Neocles
//
//  Created by Jeroen Dunselman on 07/06/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

#import "ProductTableViewController.h"
#import "ProductTVCell.h"
#import "AFNetworking.h"

@interface ProductTableViewController ()

@end

@implementation ProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self.productSearchBar setDelegate:self];
  
  [self.productTableView setDelegate:self];
  [self.productTableView setDataSource:self];
  [self.productTableView registerNib:[UINib nibWithNibName:@"ProductTVCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];

//  [self.productTableView setHidden:true];
//  [self.activityVw setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  ProductTVCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" ];
  NSDictionary *theProduct = [self.productData objectAtIndex:indexPath.row];
//  [myCell.theLabel setText : [NSString stringWithFormat:@"%@ (%@)",
//                              [theProduct objectForKey:@"Title" ],
//                              [theProduct objectForKey:@"Price" ]]];
  productCell.productPrice.text = [NSString stringWithFormat:@"%li ", (long)indexPath.row];
    return productCell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 120; //[heights_ objectAtIndex:[indexPath row]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//  if ([searchText length] == 0) {
//    self.productData = [[NSArray alloc] init];
//    [self.productTableView setHidden:true];
//  }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  isSearching = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  NSLog(@"Search Clicked");
  [searchBar resignFirstResponder];
  [self searchProducts];
}

- (void)searchProducts{
//  [self.activityVw setHidden:false];
//  [self.activityVw startAnimating];
  
  //** Create imdb urlstring from theSearchBar
  NSString *trimmedSearchText = [self.productSearchBar.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];

  //get data with accountID
  NSString *accountID = @"mockup";
  NSString *startIndex = @"100";
  NSString *urlAsString = [NSString stringWithFormat:@"https://epicuroapitest.azurewebsites.net/api/products/%@?q=%@&start=%@&num=10&type=now", accountID, trimmedSearchText, startIndex];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
  
  NSURL *URL = [NSURL URLWithString:urlAsString];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    if (error) {
      NSLog(@"Error: %@", error);
    } else {
      self.productData = [responseObject objectForKey:@"Search"];
      if ([self.productData count] > 0){
        [self getProductImages];
        [self.productTableView setHidden:false];
      } else {
        [self.productTableView setHidden:true];
      }
      [self.productTableView reloadData];
//      [self.activityVw stopAnimating];
//      [self.activityVw setHidden:true];
    }
  }];
  [dataTask resume];

}
- (void) getProductImages {
}
@end

