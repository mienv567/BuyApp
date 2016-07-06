//
//  NetworkManager.h
//  CloudCast
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 fuLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "MBProgressHUD+JY.h"

typedef void(^CompleteBlock) (NSDictionary *requestDictionary);
typedef void(^FailBlock) (NSError *error);

@interface NetworkManager : NSObject


/**
 *   启动网络操作以Get方式从远程服务器请求数据
 *
 *  @param urlString  远程服务器的地址
 *  @param parameters 接口参数集合（以键值对形式存储）
 *  @param success    服务器成功返回数据后的回调block
 *  @param failure    服务器响应失败后的回调block
 */
+(void)startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:(NSString *)urlString withParameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  启动网络操作以Post方式从远程服务器请求数据
 *
 *  @param urlString  远程服务器的地址
 *  @param parameters 接口参数集合（以键值对形式存储）
 *  @param success    服务器成功返回数据后的回调block
 *  @param failure    服务器响应失败后的回调block
 */
+(void)startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:(NSString *)urlString withParameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**
 *  上传文件
 *
 *  @param severURL            服务器地址
 *  @param filePath            文件的本地路径（@"file://path/to/image.jpg"）
 *  @param uploadProgressBlock 上传进度block
 *  @param completionHandler   上传完成的block
 */
+(void)uploadFileToServerURL:(NSString *)severURL withFilePath:(NSString *)filePath withParameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
+(void)uploadLuYinFileToServerURL:(NSString *)severURL withFilePath:(NSString *)filePath withParameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

/**
 *  下载文件
 *
 *  @param serverURL             文件的服务器路径
 *  @param downloadProgressBlock 下载进度block
 *  @param destination           文件在本地的路径
 *  @param completionHandler     下载完成时block
 */
+(void)downloadFileFromServerURL:(NSString *)serverURL progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 *  判断网络是否存在
 *
 *  @param block 判断结束后的回调block
 */
+(void)isNetworkingRunningFinishedBlock:(void (^)(BOOL running))block;

+(void)uploadImageDataByPostMethodWithURLString:(NSString *)urlString withParameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end
