//
//  UIViewController+ImagePicker.h
//  test
//
//  Created by  郑晖 on 11/01/2017.
//  Copyright © 2017 郑晖. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIImagePickerController;

typedef void(^LBPhotoPickerDidFinishSelectedMedia)(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info);
typedef void(^LBPhotoPickerDidCancel)(UIImagePickerController *imagePickerViewController);

@interface UIViewController (ImagePicker)

@property (nonatomic, copy) LBPhotoPickerDidFinishSelectedMedia didFinishSelectedMedia;
@property (nonatomic, copy) LBPhotoPickerDidCancel didCancel;

- (void)selectPhotoWithSuccessBlock:(LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia cancelBlock:(LBPhotoPickerDidCancel)didCancel;

- (void)openCameraWithSuccessBlock:(LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia cancelBlock:(LBPhotoPickerDidCancel)didCancel;

@end
