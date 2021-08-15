//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import UIKit


class ExploreViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
    }()
    
    private var sections = [ExploreSection]()
    private var collectionView: UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModel()
        setUpSearchBar()
        setUpCollectionView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    func setUpSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func setUpCollectionView(){
        let layout = UICollectionViewCompositionalLayout{section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func configureModel(){
        var cells = [ExploreCell]()
        for x in 0...1000{
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(
                    image: nil,
                    title: "title",
                    handler: {
                        
                    }
                )
            )
            cells.append(cell)
        }
        //Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: cells
            )
        )
        //Users
        sections.append(
            ExploreSection(
                type: .users,
                cells: [
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    }))
                ]
            )
        )
        
        var posts = [ExploreCell]()
        for _ in 0 ... 40{
            posts.append(ExploreCell.post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                
            })))
        }
        //Trending posts
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: posts
            )
        )
        
        //Trending hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hashtag(viewModel: ExploreHashtageViewModel(text: "#foryou", icon: nil, count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtageViewModel(text: "#foryou", icon: nil, count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtageViewModel(text: "#foryou", icon: nil, count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtageViewModel(text: "#foryou", icon: nil, count: 1, handler: {
                        
                    }))
                ]
            )
        )
        
        //Recommended
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    }))
                ]
            )
        )
        //Popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    }))
                ]
            )
        )
        
        //New
        sections.append(
            ExploreSection(
                type: .new,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, title: "", handler: {
                        
                    }))
                ]
            )
        )
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection{
        let sectionType = sections[section].type
        
        switch sectionType {
        
        case .banners:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension:  .absolute(200)
                ),
                subitems: [item])
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
        case .users:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension:  .absolute(200)
                ),
                subitems: [item])
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            //return
            return sectionLayout
           
        case .trendingPosts, .new, .recommended:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)
                ),
                subitem: item,
                count: 2)
               
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(240)
                ),
                subitems: [verticalGroup])
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            //return
            return sectionLayout
        case .trendingHashtags:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .absolute(60)
                ),
                subitems: [item]
                )
            
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)

            //return
            return sectionLayout
        case .popular:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            //group
                       
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(200)
                ),
                subitems: [item])
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            //return
            return sectionLayout
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        switch model{
        
        case .banner(let viewModel):
            break
        case .post(let viewModel):
            break
        case .hashtag(let viewModel):
            break
        case .user(let viewModel):
            break
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension ExploreViewController: UISearchBarDelegate{
    
}
