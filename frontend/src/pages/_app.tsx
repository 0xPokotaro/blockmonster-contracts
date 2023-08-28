import type { ReactElement, ReactNode } from 'react'
import type { AppProps } from 'next/app'
import type { NextPage } from 'next'
import { getDefaultWallets, RainbowKitProvider } from '@rainbow-me/rainbowkit'
import { configureChains, createConfig, WagmiConfig } from 'wagmi'
import { sepolia } from 'wagmi/chains'
import { alchemyProvider } from 'wagmi/providers/alchemy'
import { publicProvider } from 'wagmi/providers/public'
import { APP_NAME } from '@/config/constants'

import '@rainbow-me/rainbowkit/styles.css'

export type NextPageWithLayout<P = {}, IP = P> = NextPage<P, IP> & {
  getLayout?: (page: ReactElement) => ReactNode
}

type AppPropsWithLayout = AppProps & {
  Component: NextPageWithLayout
}

const ALCHEMY_ID = 'vs46Ws8Pg5sD4tyAdm3tYj7IA0pB35b3'

const { chains, publicClient } = configureChains(
  [sepolia],
  [alchemyProvider({ apiKey: ALCHEMY_ID }), publicProvider()]
)

const { connectors } = getDefaultWallets({
  appName: APP_NAME,
  projectId: '149e3f68dcfefa6b54b0b3da35eed20e',
  chains,
})

const wagmiConfig = createConfig({
  autoConnect: true,
  connectors,
  publicClient,
})

export default function App({ Component, pageProps }: AppPropsWithLayout) {
  const getLayout = Component.getLayout || ((page) => page)

  return (
    <WagmiConfig config={wagmiConfig}>
      <RainbowKitProvider coolMode modalSize="compact" chains={chains}>
        {getLayout(<Component {...pageProps} />)}
      </RainbowKitProvider>
    </WagmiConfig>
  )
}
