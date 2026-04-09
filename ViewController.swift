import UIKit

class ViewController: UIViewController {

    var enemyHealth = 50
    var playerTapDamage = 1
    var money = 0
    var monkeysOwned = 0
    var monkeyDamage = 1

    let enemyButton = UIButton(type: .system)
    let moneyLabel = UILabel()
    let upgradeTapButton = UIButton(type: .system)
    let buyMonkeyButton = UIButton(type: .system)
    
    var monkeyTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        startMonkeyAutoAttack()
    }

    func setupUI() {
        // Enemy
        enemyButton.frame = CGRect(x: 50, y: 200, width: 300, height: 300)
        enemyButton.setTitle("Monkey\nHP: \(enemyHealth)", for: .normal)
        enemyButton.titleLabel?.numberOfLines = 2
        enemyButton.titleLabel?.textAlignment = .center
        enemyButton.backgroundColor = .systemRed
        enemyButton.addTarget(self, action: #selector(tapEnemy), for: .touchUpInside)
        view.addSubview(enemyButton)

        // Money
        moneyLabel.frame = CGRect(x: 50, y: 50, width: 300, height: 50)
        moneyLabel.text = "Money: \(money)"
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(moneyLabel)

        // Upgrade Tap
        upgradeTapButton.frame = CGRect(x: 50, y: 550, width: 140, height: 50)
        upgradeTapButton.setTitle("Upgrade Tap (5$)", for: .normal)
        upgradeTapButton.backgroundColor = .systemBlue
        upgradeTapButton.tintColor = .white
        upgradeTapButton.addTarget(self, action: #selector(upgradeTap), for: .touchUpInside)
        view.addSubview(upgradeTapButton)

        // Buy Monkey
        buyMonkeyButton.frame = CGRect(x: 210, y: 550, width: 140, height: 50)
        buyMonkeyButton.setTitle("Buy Monkey (10$)", for: .normal)
        buyMonkeyButton.backgroundColor = .systemGreen
        buyMonkeyButton.tintColor = .white
        buyMonkeyButton.addTarget(self, action: #selector(buyMonkey), for: .touchUpInside)
        view.addSubview(buyMonkeyButton)
    }

    @objc func tapEnemy() {
        enemyHealth -= playerTapDamage
        checkEnemyDead()
    }

    func checkEnemyDead() {
        if enemyHealth <= 0 {
            money += 5
            moneyLabel.text = "Money: \(money)"
            enemyHealth = Int.random(in: 50...100)
        }
        enemyButton.setTitle("Monkey\nHP: \(enemyHealth)", for: .normal)
    }

    @objc func upgradeTap() {
        if money >= 5 {
            money -= 5
            playerTapDamage += 1
            moneyLabel.text = "Money: \(money)"
        }
    }

    @objc func buyMonkey() {
        if money >= 10 {
            money -= 10
            monkeysOwned += 1
            moneyLabel.text = "Money: \(money)"
        }
    }

    func startMonkeyAutoAttack() {
        monkeyTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.enemyHealth -= self.monkeysOwned * self.monkeyDamage
            self.checkEnemyDead()
        }
    }
}
