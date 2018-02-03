//
//  TableReusableView.swift
//  Reusable
//
//  Created by Ross Kimes on 1/28/18.
//  Copyright © 2018 rosskimes.net. All rights reserved.
//

public enum TableReusableType {
	case asCell, asHeaderFooterView
}

public protocol TableReusableCell: ReusableView {
	static var reuseType: TableReusableType { get }
}

extension TableReusableCell {
	
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	public static func dequeueCell(in tableView: UITableView, for indexPath: IndexPath, reuseIdentifier: String? = nil) -> Self {
		let reuseId = reuseIdentifier ?? self.reuseIdentifier
		return tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! Self
	}
	
	public static func register(in tableView: UITableView, bundle: Bundle = Bundle.main, reuseIdentifier: String? = nil) {
		
		let reuseId = reuseIdentifier ?? self.reuseIdentifier
		let nibName = self.reuseIdentifier
		
		switch (reuseSource, reuseType) {
		case (.asNib, .asCell):
			tableView.register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: reuseId)
			
		case (.asClass, .asCell):
			tableView.register(self, forCellReuseIdentifier: reuseId)
			
		case (.asNib, .asHeaderFooterView):
			tableView.register(UINib(nibName: nibName, bundle: bundle), forHeaderFooterViewReuseIdentifier: reuseId)
			
		case (.asClass, .asHeaderFooterView):
			tableView.register(self, forHeaderFooterViewReuseIdentifier: reuseId)
			
		case (.asStoryboard, _):
			break
		}
	}
}

// MARK: -

public extension TableReusableCell where Self: UITableViewCell {
	static var reuseType: TableReusableType { return .asCell }
}

public extension TableReusableCell where Self: UITableViewHeaderFooterView {
	static var reuseType: TableReusableType { return .asHeaderFooterView }
}

