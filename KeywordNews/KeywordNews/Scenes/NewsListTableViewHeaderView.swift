//  KeywordNews - NewsListTableViewHeaderView.swift
//  Created by zhilly on 2023/05/10

import SnapKit
import TTGTags
import UIKit

protocol NewsListTableViewHeaderViewDelegate: AnyObject {
    func didSelectTag(_ selectedIndex: Int)
}

final class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"

    private var tags: [String] = []
    private weak var delegate: NewsListTableViewHeaderViewDelegate?
    private lazy var tagCollectionView = TTGTextTagCollectionView()

    func setup(tags: [String], delegate: NewsListTableViewHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate

        contentView.backgroundColor = .systemBackground

        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!,
                               didTap tag: TTGTextTag!,
                               at index: UInt) {
        guard tag.selected else { return }
        
        delegate?.didSelectTag(Int(index))
    }
}

private extension NewsListTableViewHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)

        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupTagCollectionView() {
        let insetValue: CGFloat = 16.0
        
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        tagCollectionView.contentInset = UIEdgeInsets(
            top: insetValue,
            left: insetValue,
            bottom: insetValue,
            right: insetValue
        )

        let cornerRadiusValue: CGFloat = 12.0
        let shadowOpacity: CGFloat = 0.0
        let extraSpace = CGSize(width: 20.0, height: 12.0)
        let color = UIColor.systemOrange

        let style = TTGTextTagStyle()
        style.backgroundColor = color
        style.cornerRadius = cornerRadiusValue
        style.borderWidth = 0.0
        style.shadowOpacity = shadowOpacity
        style.extraSpace = extraSpace

        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = cornerRadiusValue
        selectedStyle.shadowOpacity = shadowOpacity
        selectedStyle.extraSpace = extraSpace
        selectedStyle.borderColor = color

        //tagCollectionView.removeAllTags()
        
        tags.forEach { tag in
            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            let tagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .white
            )
            let selectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: color
            )

            let tag = TTGTextTag(
                content: tagContents,
                style: style,
                selectedContent: selectedTagContents,
                selectedStyle: selectedStyle
            )

            tagCollectionView.addTag(tag)
        }
        
        tagCollectionView.reload()
    }
}
