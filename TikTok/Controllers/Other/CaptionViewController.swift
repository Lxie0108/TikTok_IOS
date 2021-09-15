//
//  CaptionViewController.swift
//  TikTok
//
//  Created by Ling Xie on 9/15/21.
//

import Foundation
import UIKit

class CaptionViewController: UIViewController{
    
    let videoURL: URL
    
    init(videoURL: URL){
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Caption"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func didTapPost(){
        
    }
}
