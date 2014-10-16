//
//  TableViewCell.h
//  团购
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

@protocol addCover <NSObject>

- (void)addcover:(NSString *)string;

@end
@interface TableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *label;

@property(nonatomic,assign)id <addCover> delagate;
- (void)addheng:(NSInteger)hang;
//- (void)addshu;

-(void)setCellWith:(NSArray*)array;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDirection:(int)direcyion;

@end
