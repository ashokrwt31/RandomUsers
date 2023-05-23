//
//  HomeScreenCellTableViewCell.h
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"
#import "RandomUsers-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserListTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;

-(void)configureCell:(UserListModel*)user modelWrapper:(UserListWrapper*)modelWrapper;

@end

NS_ASSUME_NONNULL_END
