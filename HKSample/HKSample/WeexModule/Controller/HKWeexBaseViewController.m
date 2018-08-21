//
//  HKWeexBaseViewController.m
//  WeexDemo
//
//  Created by yangzhi on 2018/8/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "HKWeexBaseViewController.h"
#import "HKMediatorManager.h"
#import "HKWeexBaseViewController+Extend.h"

@interface HKWeexBaseViewController ()
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, assign) CGFloat weexHeight;
@end

@implementation HKWeexBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 设置一些页面属性 */
    [self setupViews];
    
    /* 监听页面刷新事件 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefreshInstance:) name:@"RefreshInstance" object:nil];
    
    /* 加载weex页面 */
    [self _renderWithURL:self.url];
}

- (void)setupViews
{
    /* 设置0 0点坐标从导航栏下开始 */
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* 设置背景颜色 */
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /* 设置weex页面高度 */
    _weexHeight = [[UIScreen mainScreen]bounds].size.height;
    
    // 设置backBarItem
    [self addBackBarbuttonItem];
    
    /* 设置导航栏shadowImage */
    
    /* 设置title */
    self.title = self.routerModel.navTitle;
    
    /* 判断是否需要隐藏导航栏 并设置weex页面高度*/
    
    /* 是否禁用返回 */
    
    /* 是否禁用手势返回 */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /* 设置状态栏样式 */
    
    /* 保存当前栈顶的 WXSDKInstance 与 ViewController */
    [[HKMediatorManager shareInstance] setCurrentWXInstance:self.instance];
    
    // 通知js页面生命周期
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 通知js页面生命周期

    [self _updateInstanceState:WeexInstanceAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self _updateInstanceState:WeexInstanceDisappear];
}

//TODO get height
- (void)viewDidLayoutSubviews
{
    _weexHeight = self.view.frame.size.height;
    UIEdgeInsets safeArea = UIEdgeInsetsZero;
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        safeArea = self.view.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
#endif
    _instance.frame = CGRectMake(safeArea.left, safeArea.top, self.view.frame.size.width-safeArea.left-safeArea.right, _weexHeight-safeArea.bottom);
    
}

- (void)dealloc
{
    WXLogInfo(@"dealloc >>>>>>>>>>>>>>>>>>>>>> %@",self.navigationItem.title);
    
    [_instance destroyInstance];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_renderWithURL:(NSURL *)sourceURL
{
    if (!sourceURL) {
        WXLogError(@"error: render url is nil");
        return;
    }
    
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = CGRectMake(0, 0, self.view.frame.size.width, _weexHeight);
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf.weexView);
    };
    _instance.onFailed = ^(NSError *error) {

    };
    
    _instance.renderFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Render Finish...");
        [weakSelf _updateInstanceState:WeexInstanceAppear];
    };
    
    _instance.updateFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Update Finish...");
    };
    
    NSString *newURL = nil;
    
    if ([sourceURL.absoluteString rangeOfString:@"?"].location != NSNotFound) {
        newURL = [NSString stringWithFormat:@"%@&random=%d", sourceURL.absoluteString, arc4random()];
    } else {
        newURL = [NSString stringWithFormat:@"%@?random=%d", sourceURL.absoluteString, arc4random()];
    }
    [_instance renderWithURL:[NSURL URLWithString:newURL] options:@{} data:nil];
}

- (void)_updateInstanceState:(WXState)state
{
    if (_instance && _instance.state != state) {
        _instance.state = state;
        
        if (state == WeexInstanceAppear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
        } else if (state == WeexInstanceDisappear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
        }
    }
}

#pragma mark - notification
- (void)notificationRefreshInstance:(NSNotification *)notification {
    [self refreshWeex];
}

#pragma mark - refresh
- (void)refreshWeex
{
    /* 标示页面状态刷新 */
    
    [self _renderWithURL:self.url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
