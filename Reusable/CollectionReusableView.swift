//
//  CollectionReusableView.swift
//  Reusable
//
//  Created by Ross Kimes on 1/28/18.
//  Copyright © 2018 rosskimes.net. All rights reserved.
//

public enum CollectionReuseSource {
	case asNib, asClass
}

public enum CollectionReusableType {
	case asCell, asView(ofKind: String)
}

public protocol CollectionReusableCell: class {
	static var reuseSource: CollectionReuseSource { get }
	static var reuseType: CollectionReusableType { get }
}

extension CollectionReusableCell {
	
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	public static func dequeue(in collectionView: UICollectionView, for indexPath: IndexPath, reuseIdentifier: String? = nil) -> Self {
		
		let reuseId = reuseIdentifier ?? self.reuseIdentifier
		switch reuseType {
		case .asCell:
			return collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! Self
		case .asView(let kind):
			return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseId, for: indexPath) as! Self
		}
	}
	
	public static func register(in collectionView: UICollectionView, bundle: Bundle = Bundle.main, reuseIdentifier: String? = nil) {
		
		let reuseId = reuseIdentifier ?? self.reuseIdentifier
		let nibName = self.reuseIdentifier
		
		switch (reuseSource, reuseType) {
		case (.asNib, .asCell):
			collectionView.register(
				UINib(nibName: nibName, bundle: bundle),
				forCellWithReuseIdentifier: reuseId
			)
			
		case (.asClass, .asCell):
			collectionView.register(self, forCellWithReuseIdentifier: reuseId)
			
		case (.asNib, .asView(let kind)):
			collectionView.register(
				UINib(nibName: nibName, bundle: bundle),
				forSupplementaryViewOfKind: kind,
				withReuseIdentifier: reuseId
			)
			
		case (.asClass, .asView(let kind)):
			collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseId)
		}
	}
}


public extension CollectionReusableCell where Self: UICollectionViewCell {
	static var reuseType: CollectionReusableType { return .asCell }
}
