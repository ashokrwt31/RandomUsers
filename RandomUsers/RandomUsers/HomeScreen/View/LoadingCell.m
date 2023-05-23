//
//  LoadingCell.m
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

#import "LoadingCell.h"

@implementation LoadingCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.separatorInset = UIEdgeInsetsMake(0.f, self.bounds.size.width, 0.f, 0.f);
    self.loadingIndicator.color = [UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
