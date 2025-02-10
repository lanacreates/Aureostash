# AureoStash 💰✨

**AureoStash** is a decentralized, multichain savings and staking platform designed to empower users with goal-based financial tools. By combining savings discipline with yield optimization, AureoStash helps users grow their wealth across multiple blockchains while maintaining full control over their assets.

---

## 🚀 Features

- **🎯 Goal-Based Savings:**  
  Create customized savings plans with flexible durations and specific targets.

- **📉 Yield Optimization & Staking:**  
  Automatically stake funds to earn rewards across DeFi protocols, with seamless staking toggles.

- **💵 Stablecoin & Token Support:**  
  Save and stake using ETH or any ERC20 tokens like USDC, DAI, and more.

- **🔒 Non-Custodial & Secure:**  
  Full control over your assets with smart contract transparency and OpenZeppelin security measures.

- **⚡ Early Withdrawal Penalty:**  
  A 2% penalty applies for early withdrawals, encouraging disciplined savings.

- **📊 Transparent & On-Chain:**  
  All transactions and activities are verifiable on-chain.

---

## 🛠️ Smart Contracts

### **1. StakingManager Contract**
- **Role:** Manages staking operations and yield generation.
- **Network:** Sepolia Testnet
- **Address:** [0x5d86c15b136F97556639E37Fc6634B2804C29CCC](https://sepolia.etherscan.io/address/0x5d86c15b136F97556639E37Fc6634B2804C29CCC)
- **Verification:** [View on Etherscan](https://sepolia.etherscan.io/address/0x5d86c15b136F97556639E37Fc6634B2804C29CCC#code)

### **2. AureoStash Contract**
- **Role:** Main contract handling savings goals and user interactions.
- **Network:** Sepolia Testnet
- **Address:** [0x12FDB60A7bc992193AA24418f673Fa1AF5E7d3fA](https://sepolia.etherscan.io/address/0x12FDB60A7bc992193AA24418f673Fa1AF5E7d3fA)
- **Verification:** [View on Etherscan](https://sepolia.etherscan.io/address/0x12FDB60A7bc992193AA24418f673Fa1AF5E7d3fA#code)

---

## 🌐 Frontend Application

- **Live Demo:** [https://aureostash.vercel.app/](https://aureostash.vercel.app/)
- **Key Features:**
  - Wallet connection (MetaMask & Web3-enabled)
  - Savings goal creation interface
  - Staking management dashboard
  - User-friendly and responsive UI

---

## 🛆 Installation

### **1. Clone the Repository**

```bash
git clone https://github.com/lanacreates/AureoStash.git
cd AureoStash
```

### **2. Install Dependencies**

For both the smart contracts and frontend:

```bash
npm install
```

### **3. Environment Configuration**

Create a `.env` file in the root directory:

```env
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY
PRIVATE_KEY=your_private_key_here
ETHERSCAN_API_KEY=your_etherscan_api_key_here
```

---

## 📝 Usage

### **Deploying Smart Contracts**

1. Compile contracts:

   ```bash
   npx hardhat compile
   ```

2. Deploy to Sepolia Testnet:

   ```bash
   npx hardhat run scripts/deploy.js --network sepolia
   ```

3. Verify contracts on Etherscan:

   ```bash
   npx hardhat verify --network sepolia <CONTRACT_ADDRESS> <CONSTRUCTOR_ARGUMENTS>
   ```

---

### **Running the Frontend Locally**

1. Navigate to the frontend folder.
2. Start the development server:

   ```bash
   npm run dev
   ```

3. Visit [http://localhost:3000](http://localhost:3000) in your browser.

---

## 🔐 Security

- **OpenZeppelin Contracts:** Utilizes battle-tested libraries for ERC20 standards and security.
- **ReentrancyGuard:** Protection against reentrancy attacks.
- **Access Control:** Ensures only authorized users can perform critical actions.
- **Non-Custodial:** Users maintain full control over their funds at all times.

---

## 🧪 Testing

Run the smart contract tests using Hardhat:

```bash
npx hardhat test
```

---

## 🛡️ Known Limitations & Future Improvements

- **Edge Case Testing:** Further testing required for extreme scenarios.
- **Cross-Chain Expansion:** Future versions will support more blockchains.
- **UI/UX Enhancements:** Ongoing improvements for better user experience.
- **Referral System:** Potential integration in upcoming releases.

---

## 🧱 Contributing

1. **Fork** this repository.
2. **Create a branch**: `git checkout -b feature/YourFeature`
3. **Commit your changes**: `git commit -m 'Add some feature'`
4. **Push to the branch**: `git push origin feature/YourFeature`
5. **Submit a Pull Request**.

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.


---

## ✨ Acknowledgements

- **Web3 Unilag**: Proud sponsor of this project, supporting the development of decentralized solutions for the next generation of blockchain enthusiasts.
- Built with ❤️ using **Solidity**, **Hardhat**, and **React/TypeScript**.
- Special thanks to the testers and contributors for making AureoStash possible.

