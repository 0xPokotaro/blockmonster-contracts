// wagmi
import { useAccount, useContractWrite } from 'wagmi'
// MUI
import { Button } from '@mui/material'
// Config
import {
  MORALIS_API_KEY,
  BLOCK_MONSTER_TOKEN_ADDRESS,
} from '@/config/constants'
// Abi
import { BlockMonsterAbi } from '@/config/abis/BlockMonsterAbi'

const MintButton = () => {
  const { data, isLoading, isSuccess, write } = useContractWrite({
    address: BLOCK_MONSTER_TOKEN_ADDRESS,
    abi: BlockMonsterAbi,
    functionName: 'mint',
  })

  return (
    <Button
      variant="contained"
      disableElevation
      onClick={() => write({ args: [1, 1] })}
    >
      Mint
    </Button>
  )
}

export default MintButton
