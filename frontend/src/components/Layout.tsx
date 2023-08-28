// NextJS
import Head from 'next/head'
// MUI
import { AppBar, Container, Toolbar, Typography } from '@mui/material'
import { Menu as MenuIcon } from '@mui/icons-material'
// RainbowKit
import { ConnectButton } from '@rainbow-me/rainbowkit'
// Config
import { APP_NAME, APP_DESCRIPTION } from '@/config/constants'

interface LayoutProps {
  children: React.ReactNode
}

const Layout = ({ children }: LayoutProps) => {
  return (
    <>
      <Head>
        <title>{APP_NAME}</title>
        <meta name="description" content={APP_DESCRIPTION} />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            {APP_NAME}
          </Typography>
          <ConnectButton />
        </Toolbar>
      </AppBar>
      <Container maxWidth="lg">
        <main>{children}</main>
      </Container>
    </>
  )
}

export default Layout
