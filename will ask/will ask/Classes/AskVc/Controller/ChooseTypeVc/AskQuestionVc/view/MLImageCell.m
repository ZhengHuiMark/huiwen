//
//  MLImageCell.m
//  Test CollectionView
//
//  Created by CristianoRLong on 12/03/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import "MLImageCell.h"

@implementation MLImageModel
@synthesize image = _image;

#pragma mark - Override Setter/Getter Methods
- (void)setImage:(UIImage *)image {
    _image = image;
    if (!image) {
        self.modelType = MLImageModelTypePlaceholder;
    } else {
        self.modelType = MLImageModelTypeImage;
    }
}

- (UIImage *)image {
    if (!_image) return [UIImage imageNamed:@"add"];
    return _image;
}

@end





@interface MLImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation MLImageCell
#pragma mark - Override Setter/Getter Methods
- (void)setImageModel:(MLImageModel *)imageModel {
    _imageModel = imageModel;
    if (imageModel.urlStr.length > 0) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,imageModel.urlStr]]];
    } else {
        self.imgView.image = imageModel.image;
    }
    
}

@end

