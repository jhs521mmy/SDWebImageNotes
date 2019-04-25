/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
#import "NSData+ImageContentType.h"

/**
 A Boolean value indicating whether to scale down large images during decompressing. (NSNumber)
 一个布尔值，指示在解压缩期间是否缩小大图像
 */
FOUNDATION_EXPORT NSString * _Nonnull const SDWebImageCoderScaleDownLargeImagesKey;

/**
 Return the shared device-dependent RGB color space created with CGColorSpaceCreateDeviceRGB.

 @return The device-dependent RGB color space
 返回用cgcolorspacecreateddevicergb创建的与共享设备相关的rgb颜色空间。
 
 @返回设备相关的RGB颜色空间
 
 */
CG_EXTERN CGColorSpaceRef _Nonnull SDCGColorSpaceGetDeviceRGB(void);

/**
 Check whether CGImageRef contains alpha channel.

 @param imageRef The CGImageRef
 @return Return YES if CGImageRef contains alpha channel, otherwise return NO
 
 
 */
CG_EXTERN BOOL SDCGImageRefContainsAlpha(_Nullable CGImageRef imageRef);


/**
 This is the image coder protocol to provide custom image decoding/encoding.
 These methods are all required to implement.
 @note Pay attention that these methods are not called from main queue.
 这是提供自定义图像解码/编码的图像编码器协议。
 这些方法都是实现所必需的。
 @注意，不要从主队列调用这些方法。

 */
@protocol SDWebImageCoder <NSObject>

@required
#pragma mark - Decoding --- 解码
/**
 Returns YES if this coder can decode some data. Otherwise, the data should be passed to another coder.
 
 @param data The image data so we can look at it
 @return YES if this coder can decode the data, NO otherwise
 如果此编码器可以解码某些数据，则返回“是”。否则，数据应该传递给另一个编码器。
 
 @参数数据图像数据以便我们可以查看它
 @如果此编码器可以解码数据，则返回“是”，否则返回“否”。
 */
- (BOOL)canDecodeFromData:(nullable NSData *)data;

/**
 Decode the image data to image.

 @param data The image data to be decoded
 @return The decoded image from data
 
 将图像数据解码为图像。
 
 @参数数据要解码的图像数据
 @从数据返回解码后的图像
 */
- (nullable UIImage *)decodedImageWithData:(nullable NSData *)data;

/**
 Decompress the image with original image and image data.

 @param image The original image to be decompressed
 @param data The pointer to original image data. The pointer itself is nonnull but image data can be null. This data will set to cache if needed. If you do not need to modify data at the sametime, ignore this param.
 @param optionsDict A dictionary containing any decompressing options. Pass {SDWebImageCoderScaleDownLargeImagesKey: @(YES)} to scale down large images
 @return The decompressed image
 
 使用原始图像和图像数据解压缩图像。
 
 @param image要解压缩的原始图像
 @参数数据指向原始图像数据的指针。指针本身不为空，但图像数据可以为空。如果需要，此数据将设置为缓存。如果不需要在同一时间修改数据，请忽略此参数。
 @参数选项插入包含任何解压缩选项的字典。通过SDWebImagecoderscaleDownargeImageskey:@（是）缩小大图像
 @返回解压缩后的图像

 */
- (nullable UIImage *)decompressedImageWithImage:(nullable UIImage *)image
                                            data:(NSData * _Nullable * _Nonnull)data
                                         options:(nullable NSDictionary<NSString*, NSObject*>*)optionsDict;

#pragma mark - Encoding----  编码

/**
 Returns YES if this coder can encode some image. Otherwise, it should be passed to another coder.
 
 @param format The image format
 @return YES if this coder can encode the image, NO otherwise
 
 @param image要编码的图像
 @param format要编码的图像格式，应注意“sdimageformatfundefined”格式也是可能的。
 @返回编码后的图像数据
 
 */
- (BOOL)canEncodeToFormat:(SDImageFormat)format;

/**
 Encode the image to image data.

 @param image The image to be encoded
 @param format The image format to encode, you should note `SDImageFormatUndefined` format is also  possible
 @return The encoded image data
 @param image要编码的图像
 @param format要编码的图像格式，应注意“sdimageformatfundefined”格式也是可能的。
 @返回编码后的图像数据
 */
- (nullable NSData *)encodedDataWithImage:(nullable UIImage *)image format:(SDImageFormat)format;

@end


/**
 This is the image coder protocol to provide custom progressive image decoding.
 These methods are all required to implement.
 @note Pay attention that these methods are not called from main queue.
 
 这是图像编码协议，提供自定义渐进式图像解码。
 这些方法都是实现所必需的。
 @注意，不要从主队列调用这些方法。
 
 
 */
@protocol SDWebImageProgressiveCoder <SDWebImageCoder>

@required
/**
 Returns YES if this coder can incremental decode some data. Otherwise, it should be passed to another coder.
 
 @param data The image data so we can look at it
 @return YES if this coder can decode the data, NO otherwise
 如果此编码器可以增量解码某些数据，则返回“是”。否则，它应该传递给另一个编码器。
 
 @参数数据图像数据以便我们可以查看它
 @如果此编码器可以解码数据，则返回“是”，否则返回“否”。
 
 */
- (BOOL)canIncrementallyDecodeFromData:(nullable NSData *)data;

/**
 Incremental decode the image data to image.
 
 @param data The image data has been downloaded so far
 @param finished Whether the download has finished
 @warning because incremental decoding need to keep the decoded context, we will alloc a new instance with the same class for each download operation to avoid conflicts
 @return The decoded image from data
 将图像数据增量解码为图像。
 
 @参数数据到目前为止图像数据已经下载
 @param finished是否完成下载
 @警告：由于增量解码需要保留解码的上下文，我们将为每个下载操作分配一个具有相同类的新实例，以避免冲突。
 @从数据返回解码后的图像
 
 */
- (nullable UIImage *)incrementallyDecodedImageWithData:(nullable NSData *)data finished:(BOOL)finished;

@end
