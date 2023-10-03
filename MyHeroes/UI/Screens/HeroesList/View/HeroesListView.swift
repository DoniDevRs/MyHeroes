//
//  HeroesListView.swift
//  MyHeroes
//
//  Created by Doni on 24/07/23.
//

import UIKit

final public class HeroesListView: UIView {

    enum Section { case main }
    enum Constants {
        static let emptyView = "No found Heroes for this Search!"
    }
    
    // MARK: - PROPERTIES
    
    private var heroes: [HeroEntity] = []
    private var hasMoreHeroes = true
    private var page = 1
    private var dataSource: UICollectionViewDiffableDataSource<Section, HeroEntity>!
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = Images.backgroundImage
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .clear
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.Constants.reuseID)
        return collectionView
    }()
    
    private lazy var loadingView: MHLoadingView = {
        let loadingView = MHLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    // MARK: PUBLIC API
    
    public weak var delegate: HeroesListViewDelegate?
    
    // MARK: INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
        configureDataSource()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
        view.addSubview(loadingView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        backgroundImage.constraintToSuperView()
        
        collectionView.topTo(safeAreaLayoutGuide.topAnchor)
        collectionView.leadingTo(leadingAnchor)
        collectionView.trailingTo(trailingAnchor)
        collectionView.bottomTo(safeAreaLayoutGuide.bottomAnchor)
        
        loadingView.constraintToSuperView()
    }
    
    // MARK: - PRIVATE
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HeroEntity>(collectionView: collectionView,
                                                                             cellProvider: { (collectionView, indexPath, hero) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.Constants.reuseID, for: indexPath) as! HeroCollectionViewCell
            cell.updateView(with: hero)
            return cell
        })
    }
    
    private func updateDataSource(on heroes: [HeroEntity]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HeroEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(heroes)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func updateViewLoading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
    
    private func updateView(with heroes: [HeroEntity]) {
        if heroes.count < 50 { self.hasMoreHeroes = false}
        if heroes.isEmpty {
            let message = Constants.emptyView
            delegate?.showEmptyHeroes(with: message)
            return
        }
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout = UIHelper.createThreeColumnFlowLayout(in: self.view)
            self.heroes.append(contentsOf: heroes)
            self.updateDataSource(on: self.heroes)
            self.collectionView.reloadData()
        }
    }
}

extension HeroesListView: HeroesListViewProtocol {
    public func updateView(with viewState: HeroesListViewState) {
        switch viewState {
        case let .hasData(data):
            updateViewLoading(show: false)
            updateView(with: data)
        case let .isLoading(show):
            updateViewLoading(show: show)
            break
        case .isEmpty:
            break
        }
    }
}

extension HeroesListView: UICollectionViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreHeroes else { return }
            page += 1
            delegate?.getMoreHeroes(page: page)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroes[indexPath.item]
        delegate?.goToHeroDetailsVC(hero: hero)
    }
}
