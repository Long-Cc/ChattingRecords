//
//  ViewController.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "ViewController.h"
#import "CLMessageFrame.h"
#import "CLMessage.h"
@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mak -UITableViewDataSource 方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    static NSString *ID = @"message_cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.messageFrame = messageFrame;
    return cell;
}


#pragma mak -懒加载
//懒加载
- (NSMutableArray *)messageFrames {
    if(_messageFrames == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayMessages = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            CLMessage *model = [CLMessage messageWithDict:dict];
            CLMessageFrame *messageFrame = [[CLMessageFrame alloc] init];
            messageFrame.message = model;
            [arrayMessages addObject:messageFrame];
        }
    _messageFrames = arrayMessages;
    }
    return _messageFrames;
}

@end
