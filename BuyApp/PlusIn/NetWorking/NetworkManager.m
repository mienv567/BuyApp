//
//  NetworkManager.m
//  CloudCast
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 fuLiang. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
@implementation NetworkManager


#define TimeOut 10
#define NOT_RUNNING_NETWORK @"网络未连接，请设置网络"


#pragma mark - get 请求网络数据

+(void)startNetworkRequestDataFromRemoteServerByGetMethodWithURLString:(NSString *)urlString withParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    
        if(YES){
            [MBProgressHUD showNetworkIndicator];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer.timeoutInterval = TimeOut;
            [manager GET:urlString parameters:parameters progress:^(NSProgress *progress){
            } success:^(NSURLSessionDataTask *task, id responseObject){
                [MBProgressHUD hideNetworkIndicator];
                success(task,responseObject);
                NSLog(@"调用接口_____%@   %@",urlString,parameters);
                NSLog(@"返回数据_____%@",responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError * error){
                NSLog(@"调用接口_____%@   %@",urlString,parameters);
                [MBProgressHUD hideNetworkIndicator];
                failure(task,error);
            }];
        }else{
            [MBProgressHUD showError:NOT_RUNNING_NETWORK toView:window];
        }
}

#pragma mark - post 请求网络数据

+(void)startNetworkRequestDataFromRemoteServerByPostMethodWithURLString:(NSString *)urlString withParameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
 
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)parameters];
        if(YES){
            [MBProgressHUD showNetworkIndicator];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           
            [manager POST:urlString parameters:mdic progress:^(NSProgress *progress){
            
                
            } success:^(NSURLSessionDataTask *task, id responseObject){
            
                [MBProgressHUD hideNetworkIndicator];
                    success(task,responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError * error){
                [MBProgressHUD hideNetworkIndicator];
                failure(task,error);
            }];

        }else{
            
            [MBProgressHUD showError:NOT_RUNNING_NETWORK toView:window];
            
        }
        
}

+(void)uploadImageDataByPostMethodWithURLString:(NSString *)urlString withParameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)parameters];
    if(YES){
        [MBProgressHUD showNetworkIndicator];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:urlString parameters:mdic progress:^(NSProgress *progress){
            
            
        } success:^(NSURLSessionDataTask *task, id responseObject){
            
            [MBProgressHUD hideNetworkIndicator];
                success(task,responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError * error){
            [MBProgressHUD hideNetworkIndicator];
            failure(task,error);
        }];
        
    }else{
        
        [MBProgressHUD showError:NOT_RUNNING_NETWORK toView:window];
        
    }
    
}

#pragma mark - 上传文件

+(void)uploadFileToServerURL:(NSString *)severURL withFilePath:(NSString *)filePath  withParameters:(NSDictionary *)parameters  progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
           completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:severURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                      uploadProgressBlock(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    
                      completionHandler(response,responseObject,error);
                      
                  }];
    
    [uploadTask resume];
}

+(void)uploadLuYinFileToServerURL:(NSString *)severURL withFilePath:(NSString *)filePath withParameters:(NSDictionary *)parameters  progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
           completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:severURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"suffix" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      uploadProgressBlock(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      completionHandler(response,responseObject,error);
                      
                  }];
    
    [uploadTask resume];
}


#pragma mark - 下载文件

+(void)downloadFileFromServerURL:(NSString *)serverURL progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //@"http://example.com/download.zip"
    NSURL *URL = [NSURL URLWithString:serverURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        completionHandler(response,filePath,error);
    }];
    [downloadTask resume];
}


#pragma mark - 判断网络是否存在
+(void)isNetworkingRunningFinishedBlock:(void (^)(BOOL running))block
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                block(NO);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                block(YES);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                block(YES);
                break;
            default:
                break;
        }
        
    }];  
}

@end
