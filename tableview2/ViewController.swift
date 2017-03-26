
import UIKit
let offset_HeaderStop: CGFloat = 100

class ViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHighConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        tableView.backgroundColor = UIColor.clear
        headerView.layer.zPosition = 0

    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        var headerTransform = CATransform3DIdentity

        if offset < 0 {
            let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            if offset <= offset_HeaderStop {
                view.sendSubview(toBack: headerView)
            } else {
                view.bringSubview(toFront: headerView)

            }
        }
        headerView.layer.transform = headerTransform

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }
}
