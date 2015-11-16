//
//  TableViewCell.m
//  table里面嵌table
//
//  Created by 艾葭 on 15/11/16.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import "TableViewCell.h"

#define M_PI        3.14159265358979323846264338327950288   /* pi             */
#define M_PI_2      1.57079632679489661923132169163975144   /* pi/2           */

@interface TableViewCell()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation TableViewCell

- (void)awakeFromNib {
    
    self.tableViewSmall.scrollEnabled = NO;
    self.tableViewSmall.delegate = self;
    self.tableViewSmall.dataSource = self;
    //tableView 去掉cell的分隔线
    self.tableViewSmall.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//设置图片箭头旋转
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold{
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"cellSmall";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    cell.textLabel.text = _nameArray[indexPath.row];
    
    return cell;
}


/**
 *  代理方法通知外界选中了什么
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tableViewDidSelectWithItemName:andName:)]) {
        [self.delegate tableViewDidSelectWithItemName:self.label.text andName:_nameArray[indexPath.row]];
    }
}


/**
 *设置cell的背景色
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
}

//设置图片箭头旋转
-(void)setImageRotationWithState:(BOOL)unfold{
    double degree;
    if(unfold ){
        degree = M_PI;
    }
    else{
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _imageViewSmall.layer.transform = CATransform3DMakeRotation(degree, 1, 0, 0);
    } completion:NULL];
}

@end
