//
//  HomeScreenCellTableViewCell.m
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import "UserListTableCell.h"

@implementation UserListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
        
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userImageView.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor;
    _userImageView.layer.masksToBounds = YES;
    _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    _userImageView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(UserListModel*)user modelWrapper:(UserListWrapper*)modelWrapper {
    _nameLabel.text = user.name;
    _countryLabel.text = [modelWrapper getCountryFormatedText:user.country];
    _emailLabel.text = user.email;
    _loginTimeLabel.text = [modelWrapper getFormattedLoginStatusWithDateString:user.doj];
    
    NSURL *imageUrl = [NSURL URLWithString:user.largeImageURL];
    
    [modelWrapper getImageFrom:imageUrl on:_userImageView completion:^(UIImage * _Nullable image) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userImageView.image = image;
            });
        } else {
        }
    }];
}
@end
