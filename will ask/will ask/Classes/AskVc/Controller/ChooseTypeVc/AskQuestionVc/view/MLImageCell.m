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
    if (!_image) return [UIImage imageNamed:@"xswen"];
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
    self.imgView.image = imageModel.image;
}

@end
