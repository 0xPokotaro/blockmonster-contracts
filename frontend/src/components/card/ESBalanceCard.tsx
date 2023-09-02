import { useEffect, useState } from 'react'
import { useAccount, useContractRead } from 'wagmi'
// MUI
import {
  Breadcrumbs,
  Button,
  Card,
  CardContent,
  Typography,
} from '@mui/material'
// CONFIG
import { EvolutionStoneAbi } from '@/config/abis/EvolutionStoneAbi'
import { EVOLUTION_MONSTER_TOKEN_ADDRESS } from '@/config/constants'

const ESBalanceCard = () => {
  const { address } = useAccount()
  const { data, isSuccess, refetch } = useContractRead({
    address: EVOLUTION_MONSTER_TOKEN_ADDRESS,
    abi: EvolutionStoneAbi,
    functionName: 'balanceOf',
    args: [address],
  })

  useEffect(() => {
    if (!address) return
    refetch()
  }, [address])

  return (
    <Card>
      <CardContent>
        <Typography variant="h5" component="div">
          EvolutionStone balance
        </Typography>
        <Typography color="text.secondary">1 ES</Typography>
      </CardContent>
    </Card>
  )
}

export default ESBalanceCard
