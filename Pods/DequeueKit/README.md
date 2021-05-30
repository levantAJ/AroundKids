[![CocoaPods](https://img.shields.io/cocoapods/p/DequeueKit.svg)](https://cocoapods.org/pods/DequeueKit)
[![CocoaPods](https://img.shields.io/cocoapods/v/DequeueKit.svg)](http://cocoapods.org/pods/DequeueKit)
[![Pod License](https://cocoapod-badges.herokuapp.com/l/DequeueKit/badge.png)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Build Status](https://travis-ci.org/levantAJ/DequeueKit.svg?branch=master)](https://travis-ci.org/levantAJ/DequeueKit)

# 🧰 DequeueKit
DequeueKit falicates register &amp; dequeue UITableViewCell, UICollectionViewCell

## Requirements

- iOS 9.0 or later
- Xcode 10.0 or later

## Installation
There is a way to use DequeueKit in your project:

- using CocoaPods

### Installation with CocoaPods

```ruby
pod 'DequeueKit', '1.3'
```
### Build Project

At this point your workspace should build without error. If you are having problem, post to the Issue and the
community can help you solve it.

## How To Use

```swift
import DequeueKit
```

### UITableView

##### Register with nib

```swift
tableView.register(nib: YourTableViewCell.self)
```

##### Register with class

```swift
tableView.register(class: YourTableViewCell.self)
```

##### Dequeue with class or nib

```swift
let cell = tableView.dequeueReusableCell(type: YourTableViewCell.self, for: indexPath)
```

### UICollectionView

#### Dequeue Reusable Cell

##### Register with nib

```swift
collectionView.register(nib: YouCollectionViewCell.self)
```

##### Register with class

```swift
collectionView.register(class: YouCollectionViewCell.self)
```

#### Dequeue with class or nib

```swift
let cell = collectionView.dequeueReusableCell(type: YourTableViewCell.self, for: indexPath)
```

#### Dequeue Reusable Supplementary View

##### Register with nib

```swift
collectionView.register(nib: YourHeaderView.self, of: .header)
collectionView.register(nib: YourFooterView.self, of: .footer)
```

##### Register with class

```swift
collectionView.register(class: YourHeaderView.self, of: .header)
collectionView.register(class: YourFooterView.self, of: .footer)
```

##### Dequeue with class or nib

```swift
let headerView = collectionView.dequeueReusableSupplementaryView(type: YourHeaderView.self, of: .header, for: indexPath)

let footerView = collectionView.dequeueReusableSupplementaryView(type: YourFooterView.self, of: .footer, for: indexPath)
```

## Author
- [Tai Le](https://github.com/levantAJ)

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Licenses

All source code is licensed under the [MIT License](https://raw.githubusercontent.com/levantAJ/DequeueKit/master/LICENSE).
