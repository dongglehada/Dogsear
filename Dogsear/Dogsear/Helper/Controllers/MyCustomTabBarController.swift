//
//  TabBarController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import UIKit

class MyCustomTabBarController : UITabBarController {
    let btnMiddle : UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = .myPointColor
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width) / 2 - 30, y: -20, width: 60, height: 60)
        let aciton = UIAction { [weak self] _ in
            let rootVC = UINavigationController(rootViewController: AddBookSearchViewController(viewModel: AddBookSearchViewModel()))
            rootVC.modalPresentationStyle = .fullScreen
            self?.present(rootVC, animated: true)
        }
        btnMiddle.addAction(aciton, for: .primaryActionTriggered)
    }
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        setupCustomTabBar()
    }
    func setupCustomTabBar() {
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.secondarySystemBackground.cgColor
        shape.fillColor = UIColor.secondarySystemBackground.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = .myPointColor
    }
    
    func addSomeTabItems() {
        let bookshelfVC = BookshelfViewController(viewModel: BookshelfViewModel())
        bookshelfVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical.fill")
        )
        let bookshelf = UINavigationController(rootViewController: bookshelfVC)
        
        let profileVC = ProfileViewController(viewModel: ProfileViewModel())
        profileVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        let profile = UINavigationController(rootViewController: profileVC)
        viewControllers = [bookshelf, profile]
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 50
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}
