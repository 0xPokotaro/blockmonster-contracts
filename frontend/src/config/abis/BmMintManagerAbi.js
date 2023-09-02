export const BmMintManagerAbi = [
  { inputs: [], stateMutability: 'nonpayable', type: 'constructor' },
  { inputs: [], name: 'InsufficientFunds', type: 'error' },
  { inputs: [], name: 'NotBulkMintableToken', type: 'error' },
  { inputs: [], name: 'NotEnoughEther', type: 'error' },
  { inputs: [], name: 'Unauthorized', type: 'error' },
  {
    inputs: [],
    name: 'IS_ACTIVE',
    outputs: [{ internalType: 'uint8', name: '', type: 'uint8' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'address', name: 'tokenAddress', type: 'address' },
      { internalType: 'uint256', name: 'quantity', type: 'uint256' },
    ],
    name: 'buy',
    outputs: [],
    stateMutability: 'payable',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'address', name: 'tokenAddress', type: 'address' },
      { internalType: 'uint256', name: 'quantity', type: 'uint256' },
    ],
    name: 'mint',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [{ internalType: 'address', name: '', type: 'address' }],
    name: 'mintableTokens',
    outputs: [
      { internalType: 'uint256', name: 'price', type: 'uint256' },
      { internalType: 'address', name: 'treasury', type: 'address' },
      { internalType: 'uint8', name: 'isActive', type: 'uint8' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'address', name: 'tokenAddress', type: 'address' },
      { internalType: 'uint256', name: 'price', type: 'uint256' },
      { internalType: 'address', name: 'treasury', type: 'address' },
    ],
    name: 'setMintableToken',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
]
