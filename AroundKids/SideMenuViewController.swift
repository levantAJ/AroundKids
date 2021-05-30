//
//  SideMenuViewController.swift
//  AroundKids
//
//  Created by Tai Le on 30/05/2021.
//

import UIKit
import TheConstraints
import DequeueKit
import SceneKit
import SafetyCollection

class SideMenuViewController: UIViewController {

    private lazy var blurView: UIVisualEffectView = makeBlurView()
    private lazy var tableView: UITableView = makeTableView()

    private lazy var arObjectTypes: [USDZNodeARObjectType] = USDZNodeARObjectType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(blurView)
        blurView.edges == view.edges

        view.addSubview(tableView)
        tableView.edges == view.edges
    }

}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arObjectTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: USDZNodeARObjectTypeTableViewCell = tableView.dequeueReusableCell(type: USDZNodeARObjectTypeTableViewCell.self, for: indexPath)
        if let arObjectType: USDZNodeARObjectType = arObjectTypes[safe: indexPath.row] {
            cell.setARObjectType(arObjectType: arObjectType)
        }
        return cell
    }

}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension SideMenuViewController {
    private func makeBlurView() -> UIVisualEffectView {
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        return blurView
    }

    private func makeTableView() -> UITableView {
        let tableView: UITableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(class: USDZNodeARObjectTypeTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }
}

// MARK: - USDZNodeARObjectTypeTableViewCell

class USDZNodeARObjectTypeTableViewCell: UITableViewCell {
    private lazy var thumbnailImageView: UIImageView = makeThumbnailImageView()
    private lazy var generator: USDZNodeARObjectTypeThumbnailGenerator = USDZNodeARObjectTypeThumbnailGenerator()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.leading == contentView.leading + 16
        thumbnailImageView.top == contentView.top + 16
        thumbnailImageView.width == 100
        thumbnailImageView.bottom == contentView.bottom - 8
    }

    func setARObjectType(arObjectType: USDZNodeARObjectType) {
        generator.gennerate(
            arObjectType: arObjectType,
            size: CGSize(width: 100, height: 100)) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.thumbnailImageView.image = image
            case .failure(let error):
                print("\(error)")
                self?.thumbnailImageView.image = nil
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeThumbnailImageView() -> UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }
}
