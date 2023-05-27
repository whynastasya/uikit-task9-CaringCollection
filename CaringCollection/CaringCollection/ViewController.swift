//
//  ViewController.swift
//  CaringCollection
//
//  Created by nastasya on 26.05.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: 300, height: 400)
        collectionViewFlowLayout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
}()
    private let colors = [UIColor.systemPink, UIColor.systemPurple, UIColor.systemGreen, UIColor.systemBlue,
                          UIColor.systemYellow, UIColor.systemOrange, UIColor.magenta]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: view.layoutMargins.left, bottom: 0, right: 0)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthPlusSpacing = CGFloat(315)
        let factor = round(targetContentOffset.pointee.x / cellWidthPlusSpacing)
        let myOffset = factor * cellWidthPlusSpacing
        targetContentOffset.pointee.x = myOffset
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.alpha = 0.7
        cell.layer.cornerRadius = 30
        return cell
    }
}
