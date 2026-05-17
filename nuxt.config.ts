export default defineNuxtConfig({
  srcDir: 'src/',
  modules: ['@vite-pwa/nuxt'],
  devtools: { enabled: true },
  compatibilityDate: 'latest',
  css: ['~/assets/main.css'],
  app: {
    baseURL: '/workout/',
    head: {
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: 'icon.svg' },
        { rel: 'shortcut icon', href: 'icon.svg' },
        { rel: 'apple-touch-icon', href: 'icon.svg' },
      ],
    },
  },
  nitro: {
    preset: 'static',
    prerender: {
      crawlLinks: true,
      routes: ['/'],
    },
  },
  pwa: {
    registerType: 'autoUpdate',
    manifest: {
      name: 'Workout PWA',
      short_name: 'Workout',
      description: 'Track split workouts and progress day by day.',
      theme_color: '#171e19',
      background_color: '#eeebe3',
      display: 'standalone',
      start_url: '/workout/',
      scope: '/workout/',
      icons: [
        {
          src: 'icon.svg',
          sizes: '192x192',
          type: 'image/svg+xml',
          purpose: 'any',
        },
        {
          src: 'icon.svg',
          sizes: '512x512',
          type: 'image/svg+xml',
          purpose: 'any maskable',
        },
      ],
    },
    workbox: {
      globPatterns: ['**/*.{js,css,html,png,svg,ico,txt,woff2}'],
    },
    client: {
      installPrompt: true,
    },
    devOptions: {
      enabled: true,
      type: 'module',
    },
  },
})
