
import UIKit

final class ContactListTableViewController: UITableViewController {
  // MARK: - Properties
  private var contacts: [Contact] = []
  private let cellIdentififer = "ContactCell"
  
  @IBOutlet var contactPreviewView: ContactPreviewView!
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
  //  tableView.rowHeight = 80
   // tableView.register(ContactTableViewAutoCell.self, forCellReuseIdentifier: cellIdentififer)
    loadData()
    configureTapGesture()
    setupNavigationBar()
  }
  private func loadData(){
    contacts.append(Contact(name: "Cruz Jacqueline Espinal Nieves", photo: "rw-logo", lastMessage:
      """
      Hey, need to talk to you about this awesome project.
      Before you go to New Yorik, we have to meet.
      You won't regret it. Also, I have some some books that Hillary sent to you.
      """, lastTime: Date(timeIntervalSinceNow: -2)))
    contacts.append(Contact(
      name: "Hillary Oliver", photo: "rw-logo",
      lastMessage: "Remember to buy the milk",
      lastTime: Date(timeIntervalSinceNow: -3.2)))
    contacts.append(Contact(
      name: "Noah Librado", photo: "rw-logo",
      lastMessage: "Ok",
      lastTime: Date(timeIntervalSinceNow: -3.9)))
    contacts.append(Contact(
      name: "Yinet Nella", photo: "rw-logo",
      lastMessage: "Ok",
      lastTime: Date(timeIntervalSinceNow: -6.1)))
    contacts.append(Contact(
      name: "Cruz Alberto", photo: "rw-logo",
      lastMessage: "See you soon",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
    contacts.append(Contact(
      name: "Evan Derek", photo: "rw-logo",
      lastMessage: "I'll call you later",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
    contacts.append(Contact(
      name: "Carlos Henry", photo: "rw-logo",
      lastMessage: "I'll call you later",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentififer, for: indexPath)
      as? ContactTableViewXibCell else { fatalError("Dequeued unregistered cell.") }
    
    let contact = contacts[indexPath.row]    
    cell.nameLabel.text = contact.name
    cell.messageLabel.text = contact.lastMessage
    cell.dateLabel.text = contact.formattedDate
    return cell
  }
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let contact = contacts[indexPath.row]
    contactPreviewView.nameLabel.text = contact.name
    contactPreviewView.photoImageView.image = UIImage(named: contact.photo)
    view.addSubview(contactPreviewView)
    contactPreviewView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [ contactPreviewView.widthAnchor.constraint(equalToConstant: 150),
        contactPreviewView.heightAnchor.constraint(equalToConstant: 150),
        contactPreviewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        contactPreviewView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
    contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    contactPreviewView.alpha = 0
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.contactPreviewView.alpha = 1
      self.contactPreviewView.transform = CGAffineTransform.identity
    }
  }
  
  
  // MARK: - Method helper
  @objc private func hideContactPreview(){
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      self.contactPreviewView.alpha = 0
    } completion: { sucess in
      self.contactPreviewView.removeFromSuperview()
    }
  }
  
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideContactPreview))
    contactPreviewView.addGestureRecognizer(tapGesture)
    view.addGestureRecognizer(tapGesture)
  }
  private func setupNavigationBar(){
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarBttonTap))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  @objc private func rightBarBttonTap(_ sender:UIBarButtonItem){
    let navigationController = UINavigationController(rootViewController: NewContactController())
    self.present(navigationController, animated: true, completion: nil)
    
  }
}
