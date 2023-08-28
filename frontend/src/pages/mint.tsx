// Types
import type { ReactElement } from 'react'
// Wagmi
import { useAccount } from 'wagmi'
// Components
import Layout from '@/components/Layout'
import MintButton from '@/components/button/MintButton'
// MUI
import {
  Breadcrumbs,
  Link,
  Typography,
  Unstable_Grid2 as Grid,
} from '@mui/material'

export const MintPage = () => {
  const { address } = useAccount()

  return (
    <>
      <Grid container spacing={2} sx={{ my: 2 }}>
        <Grid xs={12}>
          <Breadcrumbs aria-label="breadcrumb">
            <Link underline="hover" color="inherit" href="/">
              HOME
            </Link>
            <Typography color="text.primary">MINT</Typography>
          </Breadcrumbs>
        </Grid>
        {address && (
          <>
            <Grid xs={12}>
              <p>メッセージ</p>
              <p>NFTを保有していません。</p>
            </Grid>
            <Grid xs={12}>
              <p>アクション</p>
              <MintButton />
            </Grid>
          </>
        )}
      </Grid>
    </>
  )
}

MintPage.getLayout = function getLayout(page: ReactElement) {
  return <Layout>{page}</Layout>
}
