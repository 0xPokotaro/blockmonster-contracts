# Sample ERC6551 contracts

## Commands

```bash
# Remove the build artifacts and cache directories
forge clean

# Build the project's smart contracts
forge build

# Deploy
forge script script/MockNFT.s.sol:MockNFTScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
```

forge install dapphub/ds-test
forge install transmissions11/solmate
forge install thirdweb-dev/contracts
forge install dmfxyz/murky
forge install ProjectOpenSea/operator-filter-registry
