//
//  TableViewCell.h
//  table里面嵌table
//
//  Created by 艾葭 on 15/11/16.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewCell;
@protocol TableViewCellDelegate <NSObject>

-(void)tableViewDidSelectWithItemName:(NSString *)itemName andName:(NSString *)name;

@end
@interface TableViewCell : UITableViewCell
@property (nonatomic, assign) id<TableViewCellDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITableView *tableViewSmall;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall;
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray *nameArray;

//设置图片箭头旋转
-(void)setImageRotationWithState:(BOOL)unfold;

@end
