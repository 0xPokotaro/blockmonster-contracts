import { useEffect, useState } from 'react'
import { useAccount, useContractRead } from 'wagmi'
import {
  Breadcrumbs,
  Button,
  Card,
  CardContent,
  Typography,
  Unstable_Grid2 as Grid,
} from '@mui/material'
// CONFIG
import { BlockMonsterAbi } from '@/config/abis/BlockMonsterAbi'
import { BLOCK_MONSTER_TOKEN_ADDRESS } from '@/config/constants'
import { set } from 'react-hook-form'

const BMBalanceCard = () => {
  const [balance, setBalance] = useState(0)

  const { address } = useAccount()
  const { data, isSuccess, refetch } = useContractRead({
    address: BLOCK_MONSTER_TOKEN_ADDRESS,
    abi: BlockMonsterAbi,
    functionName: 'balanceOf',
    args: [address],
  })

  useEffect(() => {
    if (!address) return
    refetch()
  }, [address])

  useEffect(() => {
    // if (data) setBalance(data)
    console.log(data)
  }, [data])

  return (
    <Card>
      <CardContent>
        <Typography variant="h5" component="div">
          BlockMonster balance
        </Typography>
        <Typography color="text.secondary">1 BM</Typography>
      </CardContent>
    </Card>
  )
}

export default BMBalanceCard
