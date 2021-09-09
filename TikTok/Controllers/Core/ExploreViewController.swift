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
        ExploreManager.shared.delegate = self
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
        collectionView.register(ExploreBannerCollectionViewCell.self, forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(ExplorePostCollectionViewCell.self, forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier)
        collectionView.register(ExploreUserCollectionViewCell.self, forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        collectionView.register(ExploreHashtagCollectionViewCell.self, forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func configureModel(){
        
        //Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: ExploreManager.shared.getExploreBanners().compactMap({
                    return ExploreCell.banner(viewModel: $0)
                })
            )
        )
        
        //Trending posts
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: ExploreManager.shared.getExploreTrendingPosts().compactMap({
                return ExploreCell.post(viewModel: $0)
            })
            )
        )
        
        //Users
        sections.append(
            ExploreSection(
                type: .users,
                cells: ExploreManager.shared.getExploreCreators().compactMap({
                    return ExploreCell.user(viewModel: $0)
                })
            )
        )
        
        //Trending hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: ExploreManager.shared.getExploreHashtags().compactMap({
                    return ExploreCell.hashtag(viewModel: $0)
                })
            )
        )
        
        //Popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: ExploreManager.shared.getExplorePopularPosts().compactMap({
                return ExploreCell.post(viewModel: $0)
            })
            )
        )
        
        //New, recent
        sections.append(
            ExploreSection(
                type: .new,
                cells: ExploreManager.shared.getExploreRecentPosts().compactMap({
                return ExploreCell.post(viewModel: $0)
            })
            )
        )
    }
    

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
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExploreBannerCollectionViewCell.identifier,
                    for: indexPath)as? ExploreBannerCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with:viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExplorePostCollectionViewCell.identifier,
                    for: indexPath)as? ExplorePostCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with:viewModel)
            return cell
        case .hashtag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier,
                    for: indexPath)as? ExploreHashtagCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with:viewModel)
            return cell
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExploreUserCollectionViewCell.identifier,
                    for: indexPath)as? ExploreUserCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configure(with:viewModel)
            return cell
        }
    }
    
    func collectionView(_collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView?.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let model = sections[indexPath.section].cells[indexPath.row]
        switch model{
        
        case .banner(let viewModel):
            viewModel.handler()
        case .post(let viewModel):
            viewModel.handler()
        case .hashtag(let viewModel):
            viewModel.handler()
        case .user(let viewModel):
            viewModel.handler()
        }
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapCancel))
    }

    @objc func didTapCancel() {
        navigationItem.rightBarButtonItem = nil
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = nil
        searchBar.resignFirstResponder()
    }
}

//Section Layout
extension ExploreViewController{
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
                    widthDimension: .absolute(150),
                    heightDimension:  .absolute(200)
                ),
                subitems: [item])
            
            //section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
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
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 2)
               
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(300)
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
}

extension ExploreViewController: ExploreManagerDelegate {
    func pushViewController(_ vc: UIViewController) {
        HapticsManager.shared.vibrateForSelection()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapHashtag(_ hashtag: String) {
        HapticsManager.shared.vibrateForSelection()
        searchBar.text = hashtag
        searchBar.becomeFirstResponder()
    }
}
