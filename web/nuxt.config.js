export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,
  target: "static",
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: "SnapEditify: The Best Photo and Design Tools - SnapEditify",
    htmlAttrs: {
      lang: "en",
    },
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      {
        hid: "description",
        name: "description",
        content:
          "SnapEditify features a wide selection of editing tools and free-to-use content for photo and video. It’s super intuitive and easy for anyone to get the hang of and share dynamic life.",
      },
      { name: "format-detection", content: "telephone=no" },
      {
        name: "robots",
        content: "index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1",
      },
      { name: "og:locale", content: "en_US" },
      { name: "og:type", content: "article" },
      {
        name: "og:title",
        content: "SnapEditify: The Best Photo and Design Tools - SnapEditify",
      },
      {
        name: "og:description",
        content: "SnapEditify features a wide selection of editing tools and free-to-use content for photo and video. It’s super intuitive and easy for anyone to get the hang of and share dynamic life.[keywords=design, photo, video, editor, selfie, camera, filters, remove background, transparent background, online, retouch, makeup, SnapEditify, Pixocial, remover, stickers, text, music, AR effects, template, creative, beauty cam, photo to cartoon, collage, blur, mosaic, content]",
      },
      { name: "og:url", content: "" },
      { name: "og:site_name", content: "SnapEditify" },
      {
        name: "og:image",
        content: "/images/banner.png",
      },
      { name: "og:image:width", content: "1000" },
      { name: "og:image:height", content: "522" },
      { name: "og:image:type", content: "image/png" },
      { name: "twitter:card", content: "summary_large_image" },
      {
        name: "keywords",
        content: 'design, photo, video, editor, selfie, camera, filters, remove background, transparent background, online, retouch, makeup, SnapEditify, Pixocial, remover, stickers, text, music, AR effects, template, creative, beauty cam, photo to cartoon, collage, blur, mosaic, content">  <link rel="icon" href="/favicon.ico',
      },
      {
        name: "viewport",
        content: "width=device-width, initial-scale=1, user-scalable=no",
      },
      { charset: "utf-8" },
    ],
    link: [
      { rel: "canonical", href: "" },
      { rel: "icon", type: "image/x-icon", href: "/favicon.ico" },
      {
        rel: "preload",
        as: "font",
        type: "font/ttf",
        crossorigin: "anonymous",
        href: "/fonts/1d0734ff6e16948b5e6b6fbbe64c8465.ttf",
      },
      {
        rel: "preload",
        as: "font",
        type: "font/ttf",
        crossorigin: "anonymous",
        href: "/fonts/1d0734ff6e16948b5e6b6fbbe64c8465.ttf",
      },
      {
        rel: "preload",
        as: "font",
        type: "font/ttf",
        crossorigin: "anonymous",
        href: "/fonts/1d0734ff6e16948b5e6b6fbbe64c8465.ttf",
      },
      {
        rel: "stylesheet",
        href: "/css/index.css",
      },
      {
        rel: "stylesheet",
        href: "/css/terms-policy.css",
      },
    ],
    script: [
      {
        src: "/js/header.js",
        defer: true,
      },
      {
        src: "/js/index.js",
        defer: true,
      },
      {
        src: "/js/features.js",
        defer: true,
      },
      {
        src: "/js/footer.js",
        defer: true,
      },
    ],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    [
      "@nuxtjs/firebase",
      {
        config: {
          apiKey: "AIzaSyAYSChzmSaHIgxqVoU-NnG7GNUxI1_h6sY",
          authDomain: "snapeditify-67a19.firebaseapp.com",
          projectId: "snapeditify-67a19",
          storageBucket: "snapeditify-67a19.appspot.com",
          messagingSenderId: "851709128615",
          appId: "1:851709128615:web:d465d8ccb3cd5287a19082",
          measurementId: "G-VFDK99V2TG",
        },
        services: {
          remoteConfig: true,
        },
      },
    ],
  ],

  remoteConfig: {
    settings: {
      fetchTimeoutMillis: 60000, // default
      minimumFetchIntervalMillis: 43200000, // default
    },
    defaultConfig: {
      welcome_message: "Welcome",
    },
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {},

  publicRuntimeConfig: {
    GET_APP_URL: '',
    GET_APP_STORE_URL: '',
    GET_GOOGLE_PLAY_STORE_URL: '',
    GET_APP_GALLERY_STORE_URL: '',
  },

  generate: {
    fallback: true,
  },
};
