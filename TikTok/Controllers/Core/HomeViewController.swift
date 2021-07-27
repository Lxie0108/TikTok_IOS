//
//  ViewController.swift
//  TikTok
//
//  Created by Ling Xie on 7/22/21.
//

import UIKit

class HomeViewController: UIViewController {
    
   private let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .red
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let followingPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setUpFeed()
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
    
    private func setUpFeed(){
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setUpFollowingFeed()
        setUpForYouFeed()
    }
    
    func setUpFollowingFeed(){
        guard let model = followingPosts.first else{
            return
        }
        
        followingPageViewController.setViewControllers([PostViewController(model: model)], direction: .forward, animated: false, completion: nil)
        
        followingPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingPageViewController.view)
        followingPageViewController.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(followingPageViewController)
        followingPageViewController.didMove(toParent: self)
    }
    
    func setUpForYouFeed(){
        
        guard let model = forYouPosts.first else{
            return
        }
        
        
        forYouPageViewController.setViewControllers([PostViewController(model: model)], direction: .forward, animated: false, completion: nil)
        
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }

}

extension HomeViewController: UIPageViewControllerDataSource{
    //when users swipe vertically, give user the view controller before the current view controller that the users is on
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let fromPost = (viewController as? PostViewController)?.model else{
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else{
            return nil
        }
        if index == 0{
            return nil
        }
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    //give the view controller after the current view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else{
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else{
            return nil
        }
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        return vc
     }
    
    var currentPosts:[PostModel]{
        if horizontalScrollView.contentOffset.x == 0{
            //
            return followingPosts
        }
        
        //For you
        return forYouPosts
    }
}

