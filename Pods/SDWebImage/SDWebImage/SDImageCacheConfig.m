/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDImageCacheConfig.h"

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week

@implementation SDImageCacheConfig

- (instancetype)init {
    if (self = [super init]) {
        //缓存的配置信息
        _shouldDecompressImages = YES;                         //是否解压图片，默认yes
        _shouldDisableiCloud = YES;                            //是否禁用icould备份，，默认yes
        _shouldCacheImagesInMemory = YES;                      //是否缓存到内存中，默认为yes
        _shouldUseWeakMemoryCache = YES;                       //
        _diskCacheReadingOptions = 0;
        _diskCacheWritingOptions = NSDataWritingAtomic;
        _maxCacheAge = kDefaultCacheMaxCacheAge;               //最大的缓存不过期时间， 单位为秒，默认为一周的时间
        _maxCacheSize = 0;                                     //最大的缓存尺寸，单位为字节
        _diskCacheExpireType = SDImageCacheConfigExpireTypeModificationDate;
    }
    return self;
}

@end
