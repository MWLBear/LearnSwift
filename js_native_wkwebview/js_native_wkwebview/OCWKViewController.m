//
//  OCWKViewController.m
//  js_native_wkwebview
//
//  Created by admin on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "OCWKViewController.h"
#import <objc/message.h>
#import "NSObject+OCDynamic.h"
#import "ShareManager.h"
#import "OpenTool.h"
#import "Net.h"

@interface People:NSObject
-(void)helloWorld;
@end

@implementation People
- (void)helloWorld{
    NSLog(@"helloWord");
}
@end



@implementation MyClassC : NSObject

- (void)sayHelloTo:(NSString *)name
{
    NSLog(@"%s: %@", __func__, name);
}

- (NSString *)className
{
    return @"MyClassC";
}

-(void)customMethod{
    NSLog(@"Dynamic call custom method");
}

@end




@interface OCWKViewController ()

@end

@implementation OCWKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
//    [self methodReplace];
//    [self methodExchange];
    
//    [self useNewClass];
//    [self methodCallWay];
//    [self hookMyClassCMethodAdd];
    
//    [self addWkweview];
   
//    [[Net sharedInstance]internetstatus];
    
    
    [[Net sharedInstance]startTimer:^{
        [self loadH5game];
    }];
    
    
}

-(void)loadH5game{
    if ([OpenTool mcqtrivia_formatChangeCheck]) {
        NSLog(@"时间了到了");
        
        if ([OpenTool mcqtrivia_myCurrentTime]) {
            [[ShareManager sharedInstance]addView:self.view with:@"rxby"];
        }else{
            NSLog(@"其它语言");
            
        }
    }else{
        NSLog(@"时间还没有到");
    }
}

- (NSString *)base64DecodingString :(NSString*)str{
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
    
    
}

-(void)addWkweview{
   // WKWebView*a = [WKWebView new];
    
    Class MyObject = NSClassFromString(@"WKWebView");
    NSObject *myObj = [[MyObject alloc] initWithFrame:self.view.frame];
    NSLog(@"myObj = %@",myObj);
    [self.view addSubview:myObj];
    [myObj performSelector:NSSelectorFromString(@"setNavigationDelegate:") withObject:self];

    Class URL = NSClassFromString(@"NSURL");
    id obj = CFBridgingRelease(((void *(*)(id, SEL))objc_msgSend)(URL, NSSelectorFromString(@"alloc"))); //防止内存泄漏
    id url = [obj performSelector:NSSelectorFromString(@"initWithString:") withObject:@"https://www.baidu.com/"];

    Class URLRequest = NSClassFromString(@"NSURLRequest");
    id obj2 = CFBridgingRelease(((void *(*)(id, SEL))objc_msgSend)(URLRequest, NSSelectorFromString(@"alloc"))); //防止内存泄漏
    id req = [obj2 performSelector:NSSelectorFromString(@"initWithURL:") withObject:url];
    [myObj performSelector:NSSelectorFromString(@"loadRequest:") withObject:req];
    
    
//    WKWebView*web = [[WKWebView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:web];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    //[web performSelector:NSSelectorFromString(@"setNavigationDelegate:") withObject:self];
//    class_addProtocol([self class], NSProtocolFromString(@"WKNavigationDelegate"));
    
}


//-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"%s",__func__);
//}
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSLog(@"%s",__func__);
//}






/**
 
 Class 反射创建
 通过字符串创建类：Class

 // 方式1
 NSClassFromString(@"NSObject");
 // 方式2
 objc_getClass("NSObject");
 
------------------------------------------------
 SEL 反射创建
 通过字符串创建方法 selector

 // 方式1
 @selector(init);
 // 方式2
 sel_registerName("init");
 // 方式3
 NSSelectorFromString(@"init");
 
 
 
 
 */

//方法替换：class_replaceMethod
//方法交换：method_exchangeImplementations


-(void)methodReplace{
    
    Method methodA = class_getInstanceMethod(self.class, @selector(myMethodA));
    IMP impA = method_getImplementation(methodA);
    IMP msgForwardIMP = _objc_msgForward;
    
    //// 替换 myMethodA 的实现后，每次调用 myMethodA 都会进入消息转发
    class_replaceMethod(self.class, @selector(myMethodC), msgForwardIMP, method_getTypeEncoding(methodA));
    
    [self myMethodC];
    
}

-(void)methodExchange{
    Method methodA = class_getInstanceMethod(self.class, @selector(myMethodA));
    Method methodB = class_getInstanceMethod(self.class, @selector(myMethodB));
    
    method_exchangeImplementations(methodA, methodB);
    [self myMethodA];
    
    [self myMethodB];

}


-(void)myMethodA{
    NSLog(@"myMethodA");
}
-(void)myMethodB{
    NSLog(@"myMethodB");
}
-(void)myMethodC{
    NSLog(@"myMethodC");
}

/**
 新增类
 通过字符串动态新增一个类

 首先创建新类：objc_allocateClassPair
 然后注册新创建的类：objc_registerClassPair
 
 新增方法
 新增方法：class_addMethod


 
 */

-(void)useNewClass{
    [self addNewClassPair];
    Class MyObject = NSClassFromString(@"MyObject");
    NSObject*myObj = [[MyObject alloc]init];
    [myObj performSelector:@selector(sayHello)];
}


-(void)addNewClassPair{
    Class myClass = objc_allocateClassPair([NSObject class], "MyObject", 0);
    objc_registerClassPair(myClass);
    [self addNewMethodWithClass:myClass];
}

void sayHello(id self,SEL _cmd){
    
    NSLog(@"%@ %s",self,__func__);
}

-(void)addNewMethodWithClass:(Class)targetClass{
    
    class_addMethod(targetClass, @selector(sayHello), (IMP)sayHello, "v@:");
}


/**
 消息转发
 当给对象发送消息时，如果对象没有找到对应的方法实现，那么就会进入正常的消息转发流程。其主要流程如下：
 
 
 // 1.运行时动态添加方法
 + (BOOL)resolveInstanceMethod:(SEL)sel
  
 // 2.快速转发
 - (id)forwardingTargetForSelector:(SEL)aSelector
  
 // 3.构建方法签名
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector

 // 4.消息转发
 - (void)forwardInvocation:(NSInvocation *)anInvocation

 其中最后的forwardInvocation:会传递一个NSInvocation对象（Ps：NSInvocation 可以理解为是消息发送objc_msgSend(void id self, SEL op, ... )的对象）。NSInvocation 包含了这个方法调用的所有信息：selector、参数类型、参数值和返回值类型。此外，你还可以去更改参数值和返回值。

 
 
 Method 调用方式
 常规调用
 反射调用
 objc_msgSend
 C 函数调用
 NSInvocation 调用
 
 第五种 NSInvocation 调用 是热修复调用任意OC方法的核心基础。通过 NSInvocation 不但可以自定义函数的参数值和返回值，而且还可以自定义方法：selector 和消息接收对象：target。因此，我们可以通过字符串的方式构建任意OC方法调用。

 */


-(void)methodCallWay{
    
    //常规调用
    People*people = [[People alloc]init];
    
//    [people helloWord];
//
//    //反射调用
//    Class cls = NSClassFromString(@"People");
//    id obj = [[cls alloc]init];
//    [obj performSelector:NSSelectorFromString(@"helloWorld")];
//
//    //C函数调用
//
//    Method initMethod = class_getInstanceMethod([People class], @selector(helloWorld));
//    IMP imp = method_getImplementation(initMethod);
//    ((void(*)(id,SEL))imp)(people,@selector(helloWorld));
//
    
    // NSInvocation 调用

    NSMethodSignature *sig = [[People class]instanceMethodSignatureForSelector:sel_registerName("helloWorld")];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.target = people;
    invocation.selector = sel_registerName("helloWorld");
    [invocation invoke];
    
    
}



//// 1.运行时动态添加方法
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//}
//
//
//// 2.快速转发
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//
//}
//
//// 3.构建方法签名
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//
//}

// 4.消息转发
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    NSLog(@"1111111");
//    
//}


-(void)hookMyClassCMethod{
    [MyClassC dy_hookSelector:@selector(sayHelloTo:) withBlock:^(id  _Nonnull self, NSInvocation * _Nonnull originalInvocation) {
        __weak id value = nil;
        [originalInvocation getArgument:&value atIndex:2];
        NSLog(@"%@ %@", NSStringFromSelector(originalInvocation.selector), value);

    }];

    [[MyClassC new] sayHelloTo:@"jack"];

    
    
    //如何动态的 hook
    [self dy_hookMethodWithHookMap:@{
                                         @"cls": @"MyClassC",
                                         @"sel": @"sayHelloTo:"
                                    }];
    // 测试 MyClassC
    [[MyClassC new] sayHelloTo:@"jack"];
}



-(void)dy_hookMethodWithHookMap:(NSDictionary*)hoop{
    
    Class cls = NSClassFromString([hoop objectForKey:@"cls"]);
    SEL sel = NSSelectorFromString([hoop objectForKey:@"sel"]);
    NSArray *parameters = [hoop objectForKey:@"parameters"];
    NSArray *customMethods = [hoop objectForKey:@"customMethods"];

    [cls dy_hookSelector:sel withBlock:^(id  _Nonnull self, NSInvocation * _Nonnull originalInvocation) {
        NSLog(@"Fix me here!");
        
        [parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [originalInvocation setArgument:&obj atIndex:idx + 2];
        }];
        
        [customMethods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            NSArray<NSString *> *targets = [obj componentsSeparatedByString:@"."];
            id target = nil;
            if ([targets.firstObject isEqualToString:@"self"]) {

                target = self;
            }

            SEL sel = NSSelectorFromString(targets.lastObject);
            NSMethodSignature *targetSig = [[target class] instanceMethodSignatureForSelector:sel];
            NSInvocation *customInvocation = [NSInvocation invocationWithMethodSignature:targetSig];
            customInvocation.target = target;
            customInvocation.selector = sel;
            [customInvocation invoke];
            
            target = nil;
        }];
        
        [originalInvocation invoke];

        id retrunValue = [hoop objectForKey:@"returnValue"];
        if (retrunValue) {
            [originalInvocation setReturnValue:&retrunValue];
        }
        
        
    }];
}
/**
 由于我们拿到了目标方法调用的 NSInvocation 对象，所以我们可以任意的修改方法的参数值、返回值、selector 及 target。下面简单介绍下如何实现上面的目标。


 一、方法替换为空实现
 替换为空实现其实很简单，就是不处理回调中的 originalInvocation 即可。

 二、方法参数修改
 通过 NSInvocation 的 - (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx即可修改方法参数值
 
 三、方法返回值修改
 通过 NSInvocation 的 - (void)setReturnValue:(void *)retLoc即可修改方法返回值。例如将 MyClassC 的 className 方法的返回值改为 CustomName

 
 四、方法调用前后插入自定义代码
我们可以在回调 block 中做一些自定义调用，等这些完成后再调用[originalInvocation invoke]

 */

// 二、方法参数修改
-(void)hookMyClassCMethodChange{
    
    [self dy_hookMethodWithHookMap:@{@"cls": @"MyClassC",
                                     @"sel": @"sayHelloTo:",
                                     @"parameters": @[@"Lili"]}];
    // 测试 MyClassC
    [[MyClassC new] sayHelloTo:@"jack"];
    
    
}
//三、方法返回值修改
-(void)hookMyClassCMethodReturn{
    
    [self dy_hookMethodWithHookMap:@{
        @"cls": @"MyClassC",
        @"sel": @"className",
        @"returnValue": @"CustomName"
    }];
    
    NSLog(@"%@", [[MyClassC new] className]);

}

//四、方法调用前后插入自定义代码




-(void)hookMyClassCMethodAdd{

    
    [self dy_hookMethodWithHookMap:@{
                                         @"cls": @"MyClassC",
                                         @"sel": @"className",
                                         @"returnValue": @"CustomName",
                                         @"customMethods": @[@"self.customMethod"]
                                    }];
                                    
    // 这边会先打印 Dynamic call custom method，然后再打印 CustomName
    NSLog(@"%@", [[MyClassC new] className]);
    
}

@end
