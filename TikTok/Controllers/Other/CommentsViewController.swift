//
//  CommentsViewController.swift
//  TikTok
//
//  Created by Ling Xie on 8/13/21.
//

import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func didTapCloseForComments(with viewController: CommentsViewController)
}

class CommentsViewController: UIViewController {
    private let post: PostModel
    
    weak var delegate: CommentsViewControllerDelegate?
    
    private var comments = [PostComment]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            CommentTableViewCell.self,
            forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    init(post: PostModel){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.backgroundColor = .white
        fetchPostComments()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 45, y: 10, width: 50, height: 35)
        tableView.frame = CGRect(x: 0,
                                 y: closeButton.botton,
                                 width: view.width,
                                 height: view.height - closeButton.botton)
    }
    
    @objc private func didTapClose(){
        delegate?.didTapCloseForComments(with: self)
    }
    
    func fetchPostComments(){
        self.comments = PostComment.mockComments()
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

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier:CommentTableViewCell.identifier,
            for: indexPath) as? CommentTableViewCell else{
                return UITableViewCell()
            }
        cell.configure(with: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
