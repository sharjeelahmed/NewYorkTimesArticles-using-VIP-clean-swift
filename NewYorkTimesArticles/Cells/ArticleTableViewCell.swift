//
//  ArticleTableViewCell.swift
//  TestProject
//
//  Created by shairjeel ahmed on 21/07/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var authorLabel:UILabel!
    @IBOutlet weak var articleImageView:UIImageView!

    
    var articleViewModel:ListArticles.fetchArticle.ViewModel.DisplayedArticle!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleImageView.roundCorner()
    }
    
    func setData(articleViewModel:ListArticles.fetchArticle.ViewModel.DisplayedArticle!){
        self.articleViewModel = articleViewModel
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.articleImageView.image = nil
    }
    func reloadData(){
        
        guard let articleViewModel = self.articleViewModel else{
            return
        }
        self.titleLabel.text = articleViewModel.title
        self.authorLabel.text = articleViewModel.authorNames
        self.dateLabel.text = articleViewModel.date
        articleImageView.setCustomImage(articleViewModel.imageUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
