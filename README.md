# Decentralized Real Estate Marketplace

A blockchain-based real estate marketplace built on the Stacks blockchain, enabling property tokenization, fractional ownership, and decentralized property transactions.

## Features

- 🏠 NFT-based property tokenization
- 💰 Secure escrow system for property transactions
- 📊 Fractional ownership capabilities
- 🏘️ Property rental management
- 🔨 Auction system for property sales
- 🏛️ DAO governance integration

## Smart Contract Functions

### Property Management
- `mint-property`: Create new property listings
- `buy-property`: Initiate property purchases through escrow
- `finalize-purchase`: Complete property transfers

### Fractional Ownership
- `buy-shares`: Purchase shares in properties

### Rental System
- `set-rent`: Set rental prices for properties
- `pay-rent`: Process rental payments

### Auction System
- `start-auction`: Initialize property auctions
- `place-bid`: Submit bids on properties
- `finalize-auction`: Complete auction process

### Governance
- `update-dao-governance`: Update DAO governance address

## Error Handling

The contract includes comprehensive error handling for:
- Unauthorized access
- Insufficient funds
- Property availability
- Owner verification

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourusername/Decentralized-Real-Estate-Marketplace.git
```

2. Install dependencies
```bash
clarinet install
```

3. Run tests
```bash
clarinet test
```

## Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet)
- [Stacks CLI](https://docs.stacks.co/references/stacks-cli)

## Testing

Run the test suite:
```bash
clarinet test
```

## Deployment

1. Update the contract configurations in `Clarinet.toml`
2. Deploy using Clarinet:
```bash
clarinet deploy
```

## Security

This contract implements several security measures:
- Owner-only functions
- Escrow system for safe transactions
- Principal validation
- Amount verification

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

MIT License. See [LICENSE](LICENSE) for details.


