#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    ViewController* viewController = [[ViewController alloc] init];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.tabBarItem.title = @"红色";
    navigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar.bundle/tab-1@3x.png"];
    navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar.bundle/tab-1-active@3x.png"];
    navigationController.view.backgroundColor = [UIColor orangeColor];
    
//    UIViewController* tabbar1 = [[UIViewController alloc] init];
//    tabbar1.tabBarItem.title = @"红色";
//    tabbar1.tabBarItem.image = [UIImage imageNamed:@"tabbar.bundle/tab-0@3x.png"];
//    tabbar1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar.bundle/tab-0-active@3x.png"];
//    tabbar1.view.backgroundColor = [UIColor redColor];
    
    UIViewController* tabbar2 = [[UIViewController alloc] init];
    tabbar2.tabBarItem.title = @"橙色";
    tabbar2.tabBarItem.image = [UIImage imageNamed:@"tabbar.bundle/tab-1@3x.png"];
    tabbar2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar.bundle/tab-1-active@3x.png"];
    tabbar2.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController* tabbar3 = [[UIViewController alloc] init];
    tabbar3.tabBarItem.title = @"黄色";
    tabbar3.tabBarItem.image = [UIImage imageNamed:@"tabbar.bundle/tab-2@3x.png"];
    tabbar3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar.bundle/tab-2-active@3x.png"];
    tabbar3.view.backgroundColor = [UIColor yellowColor];
    
    UITabBarController* tabbarController = [[UITabBarController alloc] init];
    [tabbarController setViewControllers:@[navigationController, tabbar2, tabbar3]];
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
