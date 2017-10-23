//
//  CLMessageCell.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "CLMessageCell.h"
#import "CLMessage.h"
#import "CLMessageFrame.h"
@interface CLMessageCell()
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UIButton *textButton;
@end

@implementation CLMessageCell
#pragma mark -重写messageFrame的setter方法
- (void)setMessageFrame:(CLMessageFrame *)messageFrame {
    //获取数据模型
    CLMessage *message = messageFrame.message;
    
    _messageFrame = messageFrame;
//分别设每个子控件的数据和Frame;
    //设置时间Label的 数据 和 Frame
    self.textLabel.text = message.time;
    self.textLabel.frame = messageFrame.timeFrame;
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置正文Button的 数据 和 Frame
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
    self.textButton.frame = messageFrame.textFrame;
    self.textButton.titleLabel.font = textFont;
    
    //设置头像ImageView的 数据 和 Frame
    NSString *iconName = message.type == 0 ? @"me":@"Other";
    self.iconImage.image = [UIImage imageNamed:iconName];
    self.iconImage.frame = messageFrame.iconFrame;
    
}

#pragma mark -重写initWithStyle
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //创建时间的UILabel
        UILabel *timeLlabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLlabel];
        self.timeLabel = timeLlabel;
        
        //创建正文消息的UIButton
        UIButton *textBtn = [[UIButton alloc] init];
        [self.contentView addSubview:textBtn];
        self.textButton = textBtn;
        
        //创建头像的UIImage
        UIImageView *iconImg = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImg];
        self.iconImage = iconImg;
        
    }
    return self;
}



+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message_cell";
    CLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[CLMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
