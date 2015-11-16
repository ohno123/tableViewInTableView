//
//  ViewController.m
//  table里面嵌table
//
//  Created by 艾葭 on 15/11/16.
//  Copyright © 2015年 艾葭. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

//BOOL unfold = false;
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewCellDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *foldArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.foldArray = [NSMutableArray arrayWithCapacity:20];

    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"plist"];
    self.dataArray = [[NSArray alloc]initWithContentsOfFile:plistPath];
    
    self.foldArray = [NSMutableArray arrayWithCapacity:[self.dataArray count]];

    for (int i= 0; i<[self.dataArray count]; i++) {
        [self.foldArray insertObject:@"0" atIndex:i];
    }
    NSLog(@"%@",self.foldArray);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell=array[0];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = _dataArray[indexPath.row];
    cell.label.text = [dic objectForKey:@"itemName"];
    cell.nameArray  = [dic objectForKey:@"nameArr"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    NSArray *nameArr  = [dic objectForKey:@"nameArr"];
    NSLog(@"%@",self.foldArray[indexPath.row]);
    if ([self.foldArray[indexPath.row] isEqualToString:@"1"]) {
        return nameArr.count * 40 + 66 + 0.5;
    }
    return 66 + 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL unfold;
    NSUInteger row= [indexPath row];
    if ([self.foldArray[row] isEqualToString:@"0"]) {
        unfold = true;
        [self.foldArray replaceObjectAtIndex:row withObject:@"1"];
    }else{
        unfold = false;
        [self.foldArray replaceObjectAtIndex:row withObject:@"0"];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
    //设置图片箭头旋转
    TableViewCell *cell = (TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setImageRotationWithState:unfold];
    
    //点击一个cell的时候自动滚动到最头上，但是不知道为什么不启作用
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark -- TableViewCellDelegate
-(void)tableViewDidSelectWithItemName:(NSString *)itemName andName:(NSString *)name{
    NSString *message = [NSString stringWithFormat:@"你选中了%@,%@",itemName,name];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
