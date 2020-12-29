//
//  DFImagePickerVCHelp.m
//  DongfengWuliu
//
//  Created by 吴志勇 on 2020/11/18.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "VideoTool.h"

@implementation VideoTool

+ (void)resizeVideoWithAsset:(AVURLAsset *)asset preferSize:(long long)preferSize doneHandler:(void(^)(NSURL *outputURL,NSError *error))doneHandler{
    
    NSString *tempFilePath = [NSString stringWithFormat:@"%@%@.mp4",NSTemporaryDirectory(),[[NSUUID UUID] UUIDString]];
     NSURL *tempPathUrl = [NSURL fileURLWithPath:tempFilePath];
    
    AVAssetExportSession *finalExport = [[AVAssetExportSession alloc] initWithAsset:asset
                                                                         presetName:AVAssetExportPresetMediumQuality];
    finalExport.outputFileType = AVFileTypeMPEG4;
    finalExport.outputURL = tempPathUrl;
    finalExport.shouldOptimizeForNetworkUse=YES;
    //大小限制
    finalExport.fileLengthLimit = preferSize;
    [finalExport exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (finalExport.status) {
                case AVAssetExportSessionStatusUnknown:
                case AVAssetExportSessionStatusCancelled:
                case AVAssetExportSessionStatusFailed:{
                    doneHandler(nil,finalExport.error);
                    break;
                }
                case AVAssetExportSessionStatusCompleted:{
                    doneHandler(tempPathUrl,nil);
                    break;
                }
                default:
                    break;
            }
        });
    }];
}

@end
