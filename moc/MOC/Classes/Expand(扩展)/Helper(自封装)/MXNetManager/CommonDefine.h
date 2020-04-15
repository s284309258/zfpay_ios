//
//  CommonDefine.h
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/21.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#ifndef MoPromo_Develop_CommonDefine_h
#define MoPromo_Develop_CommonDefine_h
#import "FBKVOController.h"
#import "NSObject+Additions.h"

typedef void(^CompletionBlock)(id data);

#define EdgesForExtendedLayoutNone() do {\
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {\
                self.edgesForExtendedLayout = UIRectEdgeNone;\
                self.automaticallyAdjustsScrollViewInsets = NO;\
            }\
        } while (0)

//typedef void (^rac_cleanupBlock_t)();
//
//static inline void rac_executeCleanupBlock (__strong rac_cleanupBlock_t *block) {
//    (*block)();
//}

//#define Block_Exec(block, ...) if (block) { block(__VA_ARGS__); };

#define Block_Exec(block, ...) do {\
                if (block) { block(__VA_ARGS__); } \
            } while (0)

#define Array_Add(array, obj) do {\
if (obj) {\
    [array addObject:obj];\
} else {\
    MLog(@"addObject for nil");\
}\
} while (0);\


/*! 主线程同步队列 */
#define Block_Exec_Main_Sync_Safe(block)          \
    if ([NSThread isMainThread]) {                  \
        block();                                        \
    } else {                                        \
        dispatch_sync(dispatch_get_main_queue(), block);\
}

/*! 主线程异步队列 */
#define Block_Exec_Main_Async_Safe(block)        \
    if ([NSThread isMainThread]) {                 \
        block();                                       \
    } else {                                       \
        dispatch_async(dispatch_get_main_queue(), block);\
}

#define metamacro_concat_(A, B) A ## B

#define metamacro_concat(A, B) \
metamacro_concat_(A, B)

#if DEBUG
#define rac_keywordify autoreleasepool {}
#else
#define rac_keywordify try {} @catch (...) {}
#endif

//#define Padding 10
#define sizef40in(size40) floorf(size40*([[UIScreen mainScreen] applicationFrame].size.width/320))
#define sizef55in(size55) floorf(size55*([[UIScreen mainScreen] applicationFrame].size.width/414))

//#define onExit \
//rac_keywordify \
//__strong rac_cleanupBlock_t metamacro_concat(rac_exitBlock_, __LINE__) __attribute__((cleanup(rac_executeCleanupBlock), unused)) = ^

#endif


