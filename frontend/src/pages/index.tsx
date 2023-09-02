// TYPES
import type { ReactElement } from 'react'
// REACT
import { useEffect } from 'react'
// WAGMI
import { useAccount } from 'wagmi'
import { BLOCK_MONSTER_TOKEN_ADDRESS } from '@/config/constants'
// MUI
import {
  Breadcrumbs,
  Button,
  Card,
  CardContent,
  Typography,
  Unstable_Grid2 as Grid,
} from '@mui/material'
import RefreshIcon from '@mui/icons-material/Refresh'
// HOOKS
import useDialog from '@/hooks/useDialog'
import useMoralis from '@/hooks/useMoralis'
// COMPONENTS
import Layout from '@/components/Layout'
import NftCard from '@/components/card/NftCard'
import MonsterMintDialog from '@/components/dialog/MonstarMintDialog'
import StoneMintDialog from '@/components/dialog/StoneMintDialog'
import BMBalanceCard from '@/components/card/BMBalanceCard'
import ESBalanceCard from '@/components/card/ESBalanceCard'

export default function Home() {
  // WAGMI
  const { address } = useAccount()
  // DIALOG
  const {
    isOpen: isMonsterMintDialog,
    handleOpen: openMonsterMintDialog,
    handleClose: closeMonsterMintDialog,
  } = useDialog()
  const {
    isOpen: isStoneMintDialog,
    handleOpen: openStoneMintDialog,
    handleClose: closeStoneMintDialog,
  } = useDialog()
  // MORALIS
  const { nfts, getNFTOwners } = useMoralis(BLOCK_MONSTER_TOKEN_ADDRESS)

  const handleRefresh = () => {
    getNFTOwners()
  }

  useEffect(() => {
    if (!address) return
    getNFTOwners()
  }, [address])

  return (
    <>
      <Grid container spacing={2} sx={{ my: 3 }}>
        <Grid xs={12}>
          <Breadcrumbs aria-label="breadcrumb">
            <Typography color="text.primary">HOME</Typography>
          </Breadcrumbs>
        </Grid>
        <Grid xs={4}>
          <BMBalanceCard />
        </Grid>
        <Grid xs={4}>
          <ESBalanceCard />
        </Grid>
        <Grid xs={12}>
          <Button
            variant="contained"
            disableElevation
            sx={{ mr: 1 }}
            onClick={openMonsterMintDialog}
          >
            MONSTER MINT
          </Button>
          <MonsterMintDialog
            isOpen={isMonsterMintDialog}
            handleClose={closeMonsterMintDialog}
          />
          <Button
            variant="contained"
            disableElevation
            sx={{ mr: 1 }}
            onClick={openStoneMintDialog}
          >
            STONE MINT
          </Button>
          <StoneMintDialog
            isOpen={isStoneMintDialog}
            handleClose={closeStoneMintDialog}
          />
          <Button
            variant="outlined"
            endIcon={<RefreshIcon />}
            onClick={handleRefresh}
          >
            REFRESH
          </Button>
        </Grid>
        {nfts.map((nft: any, index: any) => {
          return (
            <Grid key={index} xs={4}>
              {nft.tokenId && <NftCard nft={nft} />}
            </Grid>
          )
        })}
      </Grid>
    </>
  )
}

Home.getLayout = function getLayout(page: ReactElement) {
  return <Layout>{page}</Layout>
}
