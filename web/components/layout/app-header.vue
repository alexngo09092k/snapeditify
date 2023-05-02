<template lang="">
  <header id="j-header" class="layout_header">
    <div class="left-pane">
      <nuxt-link class="logo" to="/"></nuxt-link>
    </div>
    <div class="tab-wrap">
      <ul class="tabs">
        <li>
          <nuxt-link to="/" class="tab" :class="activeTab == 'HOME' ? 'active' : ''" data-name="home">
            Home
          </nuxt-link>
        </li>
        <!-- <li>
          <nuxt-link to ="/create" class="tab" :class="activeTab == 'CREATE' ? 'active' : ''" data-name="create">
            Create
          </nuxt-link>
        </li> -->
        <li class="features-block">
          <div id="j-tabFeatures" class="tab tabFeatures" :class="activeTab == 'FEATURES' ? 'active' : ''"
            data-name="features">
            <span>Features</span>
            <div class="arrow"></div>
          </div>
          <div class="features-popper hidden">
            <div class="features-content">
              <!-- <div class="features-item">
                <div class="img-wrap">
                  <img src="/images/en-features-1-4887a593.jpg" />
                </div>
                <div class="title">Portrait Editing</div>
                <div class="sub-title">
                  <nuxt-link to ="/features/face-editor" class="">
                    Face Editor
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/features/makeup-tools" class="">
                    Makeup Tools
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/features/body-editor" class="">
                    Body Editor
                  </nuxt-link>
                </div>
              </div> -->
              <div class="features-item">
                <div class="img-wrap">
                  <img src="/images/en-features-2-32fc87de.jpg" />
                </div>
                <div class="title">Design Tools</div>
                <div class="sub-title">
                  <nuxt-link to="/features/cleanup-pictures" class="">
                    Remove Objects
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to="/features/remove-background" class="">
                    Remove BG
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to="/features/cartoon-filter" class="">
                    Photo To Cartoon
                  </nuxt-link>
                </div>
                <!-- <div class="sub-title">
                  <nuxt-link to ="/features/templates" class="">
                    Templates
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/features/unlimited-content" class="">
                    Unlimited Content
                  </nuxt-link>
                </div> -->
              </div>

              <!-- <div class="features-item">
                <div class="img-wrap">
                  <nuxt-link to ="/video/" target="_blank">
                    <img src="/images/en-features-3-f7f389be.jpg" />
                  </nuxt-link>
                </div>
                <div class="title">Promo Video Maker</div>
                <div class="sub-title">
                  <nuxt-link to ="/video/#ai-video-generator" target="_blank">
                    AI Video Generator
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/video/#watermark-remover" target="_blank">
                    Watermark Remover
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/video/#video-enhancer" target="_blank">
                    Video Enhancer
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/video/#magic-replace" target="_blank">
                    Magic Replace
                  </nuxt-link>
                </div>
                <div class="sub-title">
                  <nuxt-link to ="/video/#brand-kit" target="_blank">
                    Brand Kit
                  </nuxt-link>
                </div>
              </div> -->

            </div>
          </div>
        </li>
        <li class="discover-block">
          <div id="j-tabDiscover" class="tab tabDiscover" :class="activeTab == 'DISCOVER' ? 'active' : ''"
            data-name="discover">
            <span>Discover</span>
            <div class="arrow"></div>
          </div>
          <div class="discover-popper hidden">
            <div class="discover-items">
              <!-- <nuxt-link to="/editing-hacks/" data-type="edit hacks" class="discover-item j-menu">
                <div class="img-wrap">
                  <img src="/images/en-editingHacks-6c01b082.png" />
                </div>
                <div class="title">Editing Hacks</div>
              </nuxt-link> -->
              <nuxt-link to="/partnership" data-type="partnership" class="discover-item j-menu">
                <div class="img-wrap">
                  <img src="/images/en-partnership-52fe8a2f.png" />
                </div>
                <div class="title">Partnership</div>
              </nuxt-link>

              <nuxt-link to="/faq" data-type="faq" class="discover-item j-menu">
                <div class="img-wrap">
                  <img src="/images/en-FAQ-b2634db4.png" />
                </div>
                <div class="title">FAQ</div>
              </nuxt-link>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <div class="btn-wrap">
      <button class="download appDownload" data-loc="menu">Download</button>
      <div id="j-headerMenu" class="menu"></div>
    </div>
    <!-- <div class="login-wrap" id="j-loginWrap">
      <button class="login j-loginBtn">Log in</button>
    </div> -->
  </header>
</template>
<script>
  export default {
    name: 'app-header',
    data: () => ({
      activeTab: 'HOME', /// HOME, CREATE, FEATURES, DISCOVER
    }),
    methods: {
      _checkTabActive() {
        let name = this.$route.name;
        if (['home', 'index'].includes(name)) {
          this.activeTab = 'HOME';
        } else if (['create'].includes(name)) {
          this.activeTab = 'CREATE';
        } else if (['features-cartoon-filter', 'features-cleanup-pictures', 'features-remove-background'].includes(name)) {
          this.activeTab = 'FEATURES';
        } else if ([].includes(name)) {
          this.activeTab = 'DISCOVER';
        }
      }
    },
    watch: {
      $route(_, __) {
        console.log(_);
        this._checkTabActive();
      }
    },
    mounted() {
      this._checkTabActive();
    },

  }
</script>
<style lang="">

</style>