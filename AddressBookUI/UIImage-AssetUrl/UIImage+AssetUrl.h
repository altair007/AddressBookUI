//
//  UIImage+AssetUrl.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-13.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AssetUrl)
/**
 *  通过assetUrl获取图片.
 *
 *  @param assetUrl 字符串形式的本地图片的assetUrl路径.
 *  @param success  成功获取到图片后执行的操作.
 *  @param fail     获取图片失败时执行的操作.
 */
- (void) imageForAssetUrl: (NSString *) assetUrl
                  success: (void(^)(UIImage *)) successBlock
                     fail: (void(^)()) failBlock;
@end
