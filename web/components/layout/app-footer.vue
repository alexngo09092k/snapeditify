<template lang="">
  <footer id="j-footer" class="layout_footer">
    <div class="info">
      <div class="desc">
        <div class="desc-logo">
          <img src="/images/logo.png" />
          SnapEditify
        </div>
        <div class='content-text'>
          SnapEditify is here to help you capture and share your life in dynamic ways using hundreds of filters,
          stickers, makeup tools, special effects, and much more!
        </div>
      </div>
      <!-- <div class="faceBody">
        <div class="title">Portrait Editing</div>
        <div class="text-item"><a class="content-text" href='/features/face-editor'>Face Editor</a></div>
        <div class="text-item"><a class="content-text" href='/features/makeup-tools'>Makeup Tools</a></div>
        <div class="text-item"><a class="content-text" href='/features/body-editor'>Body Editor</a></div>
      </div> -->
      <div class="designTools">
        <div class="title">Design Tools</div>
        <div class="text-item"><a class="content-text" href='/features/cleanup-pictures'>Remove Objects</a></div>
        <div class="text-item"><a class="content-text" href='/features/remove-background'>Remove BG</a>
        </div>
        <div class="text-item"><a class="content-text" href='/features/cartoon-filter'>Photo To Cartoon</a></div>
        <!-- <div class="text-item"><a class="content-text" href='/features/templates'>Templates</a></div>
        <div class="text-item"><a class="content-text" href='/features/unlimited-content'>Unlimited Content</a> -->
        <!-- </div> -->
      </div>
      <div class="explore">
        <div class="title">EXPLORE</div>
        <!-- <div class="text-item"><a class="content-text" href='/editing-hacks/'>Blog</a>
        </div> -->

        <div class="text-item"><a class="content-text" href='/faq'>FAQ</a></div>

        <!-- <div class="text-item"><a class="content-text" href='https://batman.meitu.com/h5/projects/ce4d2f24de134cab8dd5a87824616a42?lang=en' target='_blank'>Video
            Tutorial</a></div> -->
        <!-- <div class="text-item"><a class="content-text" href='/video/'>SnapEditify Video</a>
        </div> -->
      </div>
      <div class="contact">
        <div class="title">CONTACT US</div>
        <div class="text-item"><a class="content-text" href="/partnership">Partnership</a></div>
        <div class="text-item"><a class="content-text" href="/support">Support</a></div>
      </div>
      <div class="freeApp">
        <div class="title">GET THE FREE APP</div>
        <div class="text-item">
          <a :href="$config.GET_APP_STORE_URL" target='_blank'>
            <img src="/images/appstore.svg" />
          </a>
        </div>
        <div class="text-item">
          <a :href="$config.GET_GOOGLE_PLAY_STORE_URL" target='_blank'>
            <img src="/images/googleplay.svg" />
          </a>
        </div>
        <div class="text-item">
          <a :href="$config.GET_APP_GALLERY_STORE_URL" target='_blank'>
            <img src="/images/app-gallery.png" />
          </a>
        </div>
        <!-- <div class="text-item">
          <div class="qr-img">
            <img src="/images/qr_code-36c08232.jpg" />
          </div>
        </div> -->
      </div>
    </div>
    <div class="copyright">
      <div class="lang-wrap" id="j-lang" data-active-lang="en">

        <div class="lang">
          <i class="earth"></i>

          <span>English</span>

          <i class="arrow"></i>
        </div>
        <div class="lang-popper" id="j-lang-popper">
          <div class="lang-items">
            <div class="lang-item j-lang active" data-type="lang_en" data-name="English">
              <a class="title" rel="nofollow" href="/">English</a>
            </div>
          </div>
        </div>

      </div>
      <div class="privacy">
        <nuxt-link to="/terms-of-service/">Terms of Service</nuxt-link>
        <div class="split"></div>
        <nuxt-link to="/privacy-policy/">Privacy Policy</nuxt-link>
      </div>
      <div class="version">
         © 2023 SnapEditify Team.
      </div>
    </div>
  </footer>
</template>
<script>
export default {
  name: 'app-footer',
}
</script>
<style lang="">

</style>