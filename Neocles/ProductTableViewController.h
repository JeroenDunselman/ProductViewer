//
//  ProductTableViewController.h
//  Neocles
//
//  Created by Jeroen Dunselman on 07/06/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
  BOOL isSearching;
}
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *productSearchBar;
@property (nonatomic, strong) NSArray *productData;
@end
