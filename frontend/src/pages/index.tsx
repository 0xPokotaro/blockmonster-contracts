import Head from 'next/head'
import { AppBar, Box, Container, Button, IconButton, Toolbar, Typography, Unstable_Grid2 as Grid } from '@mui/material'
import { Menu as MenuIcon } from '@mui/icons-material'
import { ConnectButton } from '@rainbow-me/rainbowkit'
import { APP_NAME, APP_DESCRIPTION } from '@/config/constants'
import { useContractReads } from 'wagmi'
const wagmigotchiContract = {
  address: '0xecb504d39723b0be0e3a9aa33d646642d1051ee1',
  abi: wagmigotchiABI,
}

export default function Home() {
  return (
    <>
      <Head>
        <title>{APP_NAME}</title>
        <meta name="description" content={APP_DESCRIPTION} />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Box>
        <AppBar position="static">
          <Toolbar>
            <IconButton
              size="large"
              edge="start"
              color="inherit"
              aria-label="menu"
              sx={{ mr: 2 }}
            >
              <MenuIcon />
            </IconButton>
            <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
              {APP_NAME}
            </Typography>
            <ConnectButton />
          </Toolbar>
        </AppBar>

        <Container maxWidth="lg">
          <Grid container spacing={2} sx={{ my: 2 }}>
            <Grid xs={12}>
              <p>メッセージ</p>
              <p>NFTを保有していません。</p>
            </Grid>
            <Grid xs={12}>
              <p>アクション</p>
              <Button variant="contained" disableElevation>Mint</Button>
            </Grid>
          </Grid>
        </Container>
      </Box>
    </>
  )
}
