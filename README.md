# BlockMonster

## 🪐 Features

1. Full on-chain with ERC721A and ERC6551
2. Evolution Mechanism
3. Access Control via Mint Manager

## 👾 Contracts

### BlockMonster

|Name|Network|Contract address|
|:---|:---|:---|
|BlockMonster|Polygon Mumbai|[0x38Cb1AbAb9853c01DB100764413df0F9D26edF03](https://mumbai.polygonscan.com/address/0x38Cb1AbAb9853c01DB100764413df0F9D26edF03#code)|
|ERC6551Registry|Polygon Mumbai|[0x42735056E2173C1f4eA24d8753169724FC1685Ab](https://mumbai.polygonscan.com/address/0x42735056E2173C1f4eA24d8753169724FC1685Ab#code)|
|ERC6551Implementation|Polygon Mumbai|[0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c](https://mumbai.polygonscan.com/address/0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c#code)|

### EvolutionStone

|Name|Network|Contract address|
|:---|:---|:---|
|EvolutionStone|Polygon Mumbai|[0x761691FBC93f7A2BcFb2ef700B53bd4C3C93Fc73](https://mumbai.polygonscan.com/address/0x761691FBC93f7A2BcFb2ef700B53bd4C3C93Fc73#code)|

### BmMintManager

|Name|Network|Contract address|
|:---|:---|:---|
|BmMintManager|Polygon Mumbai|[0x5bb31bB5d1053b780671Eb0188D85b142f614E50](https://mumbai.polygonscan.com/address/0x5bb31bB5d1053b780671Eb0188D85b142f614E50#code)|

## 🛰️ Getting Started

### Deploy command

```bash
# BlockMonster
forge script \
  script/deploy/blockMonster/BlockMonster.s.sol:BlockMonsterScript \
  --rpc-url https://polygon-mumbai.g.alchemy.com/v2/SU5ApLPB1TrjGPzjJChmsL0XVXVykZqC \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# EvolutionStone
forge script \
  script/deploy/evolutionStone/EvolutionStone.s.sol:EvolutionStoneScript \
  --rpc-url https://polygon-mumbai.g.alchemy.com/v2/SU5ApLPB1TrjGPzjJChmsL0XVXVykZqC \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# ERC6551Registry
forge script \
  script/blockMonster/ERC6551Registry.s.sol:ERC6551RegistryScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# ERC6551Implementation
forge script \
  script/blockMonster/ERC6551Implementation.s.sol:ERC6551ImplementationScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# BMMintableManager
forge script \
  script/deploy/bmMintManager/BmMintManager.s.sol:BmMintManagerScript \
  --rpc-url https://polygon-mumbai.g.alchemy.com/v2/SU5ApLPB1TrjGPzjJChmsL0XVXVykZqC \
  --broadcast \
  --legacy \
  --verify \
  -vvvv
```
