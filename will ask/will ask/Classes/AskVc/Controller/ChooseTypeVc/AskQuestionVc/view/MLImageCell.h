//
//  MLImageCell.h
//  Test CollectionView
//
//  Created by CristianoRLong on 12/03/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MLImageModelType) {
    MLImageModelTypePlaceholder = 0, // 默认为占位图状态, 占位图使用 "" 这个图片
    MLImageModelTypeImage, // 设置图片后, 会变为真是图片.
    MLImageModelTypeUrl    // 网络图
};

@interface MLImageModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) MLImageModelType modelType;
@property (nonatomic, copy) NSString *urlStr;
@end



@interface MLImageCell : UICollectionViewCell

@property (nonatomic, strong) MLImageModel *imageModel;

@end





