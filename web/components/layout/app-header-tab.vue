<template lang="">
    <div id="j-headerTab" class="header-tab hidden">
      <ul class="tabs">
        <li>
          <nuxt-link to="/" class="tab active" data-name="home">Home</nuxt-link>
        </li>
        <li class="features-block">
          <div class="tab " data-name="features">
            <span>Features</span>
            <div class="arrow"></div>
          </div>
        </li>
        <li class="sub-menu features-menu">
          <ul>
            <!-- <li>
              <nuxt-link class="subTab j-menu " to="/features/face-editor">
                Face Editor
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu " to="/features/makeup-tools">
                Makeup Tools
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu " to="/features/body-editor">
                Body Editor
              </nuxt-link>
            </li> -->
            <li>
              <nuxt-link class="subTab j-menu " to="/features/cleanup-pictures">
                Remove Objects
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu " to="/features/remove-background-from-photos">
                Remove BG
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu " to="/features/cartoon-filter">
                Photo To Cartoon
              </nuxt-link>
            </li>
            <!-- <li>
              <nuxt-link class="subTab j-menu " to="/features/templates">
                Templates
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu " to="/features/unlimited-content">
                Unlimited Content
              </nuxt-link>
            </li>
            <li>
              <nuxt-link class="subTab j-menu" to="/video/">
                Promo Video Maker
              </nuxt-link>
            </li> -->
          </ul>
        </li>
        <!-- <li class="discover-block">
          <div class="tab " data-name="discover">
            <span>Discover</span>
            <div class="arrow"></div>
          </div>
        </li> -->
        <li class="sub-menu discover-menu">
          <ul>
            <!-- <li>
              <nuxt-link to="/editing-hacks/" data-type="edit hacks" class="subTab j-menu" data-name="editingHacks">
                Editing Hacks
              </nuxt-link>
            </li> -->
            <li>
              <nuxt-link to="/partnership/" data-type="partnership" class="subTab j-menu" data-name="partnership">
                Partnership
              </nuxt-link>
            </li>

            <li>
              <nuxt-link to="/faq" data-type="faq" class="subTab j-menu" data-name="FAQ">
                FAQ
              </nuxt-link>
            </li>
          </ul>
        </li>
      </ul>
    </div>

</template>
<script>
export default {
  name: 'app-header-tab',
}
</script>
<style lang="">
    
</style>