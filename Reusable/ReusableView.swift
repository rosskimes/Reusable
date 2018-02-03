//
//  ReusableView.swift
//  Reusable
//
//  Created by Ross Kimes on 2/3/18.
//  Copyright © 2018 rosskimes.net. All rights reserved.
//

public enum ReusableViewSource {
	case asNib, asClass, asStoryboard
}

public protocol ReusableView: class {
	static var reuseSource: ReusableViewSource { get }
}

public extension ReusableView {
	static var reuseSource: ReusableViewSource { return .asStoryboard }
}
