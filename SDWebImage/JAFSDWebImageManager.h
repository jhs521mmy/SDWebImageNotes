//
//  JAFSDWebImageManager.h
//  SDWebImage
//
//  Created by 阿飞 on 2019/3/11.
//  Copyright © 2019年 阿飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
@interface JAFSDWebImageManager : NSObject

+ (nullable instancetype)shareSDWebImageManager;

-(void)clearCacheMemory;

-(void)clearCacheDisk;

@end
