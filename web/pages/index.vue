<template lang="">
  <div class="page">
    <!-- 概述 -->
    <section class="description-wrap" id="photoEdit">
      <div class="description-title">Simple Yet Powerful Design Tools</div>
      <div class="description-content">SnapEditify offers intuitive photo and video solutions for everyone. iOS,
        Android apps and Web tools are all available to help you share your life in dynamic ways, or boost
        productivity easily. Edit &amp; share from any device, any time, anywhere.</div>
      <div class="btn-wrap">
        <!-- <a class="try try-btn" data-loc="top" href="/create">Try for free</a> -->
        <a data-loc="top" :href="$config.GET_APP_URL" target="_blank"
          class="download noColor webDownload">
          Download
        </a>
        <button class="download appDownload" data-loc="top">Download</button>
      </div>
      <div class="video-container">
        <div class="video-bg">
          <div class="video-wrap desc-video-wrap">
            <video id="j-mainVideo" playsinline webkit-playsinline
              poster="/images/en-descPoster-789986b6.png"
              src="/22b6b757a06b0d51aeb3cf6518cff738.mp4" class="video" muted preload loop>
              Your browser not support to play video.
            </video>
          </div>
        </div>
      </div>
    </section>
    <!-- 配方 -->
    <section class="block-wrap template-wrap j-lazyrender j-revel" data-name="template">
      <div class="operate-block">
        <button class="download btnColor appDownload" data-loc="templates">
          Download
        </button>
      </div>
      <div class="image-block">
              <div class="group-bg">
                <div class="sort-wrap">
                  <div class="sort-item template-item j-tpl active" data-type="template_1">
                  </div>
                  <div class="sort-item template-item j-tpl" data-type="template_2">
                  </div>
                  <div class="sort-item template-item j-tpl" data-type="template_3">
                  </div>
                </div>
                <div class="assets-wrap">
                  <div class="asset1 template-asset">
                    <img src="/images/en-template1-1-a71a3d1e.jpg" />
                  </div>
                  <div class="asset2 template-asset">
                    <video id="j-tplVideo" playsinline webkit-playsinline poster="/images/en-templatePoster1-b8c5a4a1.jpg"
                            src="/f4200ddf5431f89891166a1a53189ad4.mp4"
                            class="video" muted preload>
                      Your browser not support to play video.
                    </video>
                  </div>
                  <div class="asset3 template-asset">
                    <img src="/images/en-template1-2-0584c5bd.jpg" />
                  </div>
                </div>
              </div>
      </div>
      <div class="text-block">
        <div class="content-wrap">
          <div class="title">Ready-to-use<br /><span class="pink">Templates</span></div>
          <div class="desc-content">Complex design skills are not required; you can make the same eye-catching edits
            to photos and videos with just one tap.</div>
          <div class="btn-wrap">
            <a class="try btnColor" data-loc="templates" :href="$config.GET_APP_URL" target="_blank">Try It Now</a>
            <!-- <a data-loc="templates" :href="$config.GET_APP_URL" target="_blank" class="download noColor webDownload">
              Download
            </a> -->
          </div>
        </div>
      </div>
    </section>
    <!-- 贴纸/文字 -->
    <section class="block-wrap sticker-wrap j-lazyrender j-revel" data-name="sticker">
      <div class="text-block">
        <div class="content-wrap">
          <div class="title">Get Creative With<br /><span class="green">Unlimited Content</span></div>
          <div class="desc-content">Remix your image/videos and create awesome work with 1,000+ stickers, text,
            brushes, background patterns.</div>
          <div class="btn-wrap">
            <a class="try btnColor" data-loc="unlimited content" :href="$config.GET_APP_URL" target="_blank">Try It Now</a>
            <!-- <a data-loc="unlimited content" :href="$config.GET_APP_URL" target="_blank" class="download noColor webDownload">
              Download
            </a> -->
          </div>
        </div>
      </div>
      <div class="image-block">
              <div class="group-bg">
                <div class="sort-wrap">
                  <div class="sort-item sticker-item j-sticker active" data-type="sticker_1">
                  </div>
                  <div class="sort-item sticker-item j-sticker" data-type="sticker_2">
                  </div>
                </div>
                <div class="assets-wrap">
                  <img src="/images/en-sticker-e5f2eb5c.jpg" class="sticker-asset" />
                </div>
              </div>
      </div>
      <div class="operate-block">
        <button class="download btnColor appDownload" data-loc="unlimited content">
          Download
        </button>
      </div>
    </section>
    <!-- 面容 -->
    <section class="block-wrap face-wrap j-lazyrender j-revel" data-name="face">
      <div class="operate-block">
        <button class="download btnColor appDownload" data-loc="face editor">
          Download
        </button>
      </div>
      <div class="image-block">
              <div class="group-bg">
                <div class="sort-wrap" id="j-face">
                  <div class="sort-item face-item active" data-type="face_1">
                  </div>
                  <div class="sort-item face-item" data-type="face_2">
                  </div>
                  <div class="sort-item face-item" data-type="face_3">
                  </div>
                  <div class="sort-item face-item" data-type="face_4">
                  </div>
                </div>
                <div class="assets-wrap">
                  <div class="asset">
                    <video id="j-faceVideo" playsinline webkit-playsinline poster="/images/en-facePoster-e6f71234.jpg" src="/ee2b4faaa116c3a25294bf0c41d6310e.mp4" class="video face-asset" muted preload loop>
                      Your browser not support to play video.
                    </video>
                  </div>
                </div>
              </div>
      </div>
      <div class="text-block">
        <div class="content-wrap">
          <div class="title">Your Best<br /><span class="purple">Face Editor</span></div>
          <div class="desc-content">You will find all the tools you need to reshape your face or body in the app, and
            you can also try out different makeup looks for refreshing looks that will help you take perfect selfies.
          </div>
          <div class="btn-wrap">
            <a data-loc="face editor" :href="$config.GET_APP_URL" target="_blank"
              class="download btnColor webDownload">
              Download
            </a>
          </div>
        </div>
      </div>
    </section>
    <!-- 抠图 -->
    <section class="block-wrap remove-wrap j-lazyrender j-revel" data-name="remove">
      <div class="text-block">
        <div class="content-wrap">
          <div class="title">Intuitive Photo & Video<br /><span class="blue">Editing Tools</span></div>
          <div class="desc-content">Whether you&#39;re looking for tools to help you trim videos or add animated
            transitions, or you want to erase unwanted objects or remove backgrounds from photos, you&#39;ll find
            whichever editing tool you need here to help you edit with ease and within seconds.</div>
          <div class="btn-wrap">
            <a class="try btnColor" data-loc="editing tools" :href="$config.GET_APP_URL" target="_blank">Try It Now</a>
            <!-- <a data-loc="editing tools"  target="_blank" class="download noColor webDownload">
              Download
            </a> -->
          </div>
        </div>
      </div>
      <div class="image-block">
              <div class="group-bg">
                <div class="assets-wrap">
                  <img src="/images/en-remove-2e72ad6d.jpg" class="remove-asset" />
                </div>
              </div>
      </div>
      <div class="operate-block">
        <button class="download btnColor appDownload" data-loc="editing tools">
          Download
        </button>
      </div>
    </section>
    <!-- Blog -->

    <section class="blog-wrap j-revel">
      <div class="title">Editing Hacks</div>
      <div class="hack-wrap">
        <div class="hack-blocks">

          <div class="hack-item">
            <div class="img-wrap">
              <div class="img-bg">
                <img src="/images/Winter-Aesthetic-25.jpg" />
              </div>
              <a href="/the-best-nail-design-photos-and-editing-tutorials/">
                <img src="/images/Winter-Aesthetic-25.jpg" />
              </a>
            </div>

            <div class="feature">

              <a href="/category/creative-tips/">Creative Tips</a>

              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title"><a href="/the-best-nail-design-photos-and-editing-tutorials/">The Best Nail Design Photos and Editing Tutorials</a></div>
          </div>

          <div class="hack-item">
            <div class="img-wrap">
              <div class="img-bg">
                <img src="/images/Winter-Aesthetic-23.jpg" />
              </div>
              <a href="/what-is-pantone-color-of-the-year-for-2023-and-how-to-use-it/">
                <img src="/images/Winter-Aesthetic-23.jpg" />
              </a>
            </div>

            <div class="feature">

              <a href="/category/creative-tips/">Creative Tips</a>

              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title">
              <a href="/what-is-pantone-color-of-the-year-for-2023-and-how-to-use-it/">
                What is Pantone Color of the Year for 2023 and how to use it?
              </a>
            </div>
          </div>

          <div class="hack-item">
            <div class="img-wrap">
              <div class="img-bg">
                <img src="/images/5.jpg" />
              </div>
              <a href="/6-popular-aesthetic-outfits-trends-for-2023-how-to-edit-your-ootd-photos/">
                <img src="/images/5.jpg" />
              </a>
            </div>

            <div class="feature">
              <a href="/category/creative-tips/">Creative Tips</a>
              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title">
              <a href="/6-popular-aesthetic-outfits-trends-for-2023-how-to-edit-your-ootd-photos/">
                6 Popular Aesthetic Outfits Trends for 2023 &amp; How to Edit Your OOTD Photos
              </a>
            </div>
          </div>

          <div class="hack-item">
            <div class="img-wrap">
              <a href="/the-best-nail-design-photos-and-editing-tutorials/">
                <img src="/images/Winter-Aesthetic-25.jpg" />
              </a>
              <div class="img-bg">
                <img src="/images//Winter-Aesthetic-25.jpg" />
              </div>
            </div>

            <div class="feature">

              <a href="/category/creative-tips/">Creative Tips</a>

              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title">
              <a href="/the-best-nail-design-photos-and-editing-tutorials/">The Best Nail
                Design Photos and Editing Tutorials
              </a>
            </div>
          </div>

          <div class="hack-item">
            <div class="img-wrap">
              <a href="/what-is-pantone-color-of-the-year-for-2023-and-how-to-use-it/">
                <img src="/images/Winter-Aesthetic-23.jpg" />
              </a>
              <div class="img-bg">
                <img src="/images/Winter-Aesthetic-23.jpg" />
              </div>
            </div>

            <div class="feature">

              <a href="/category/creative-tips/">Creative Tips</a>

              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title">
              <a href="/what-is-pantone-color-of-the-year-for-2023-and-how-to-use-it/">
                What is Pantone Color of the Year for 2023 and how to use it?
              </a>
            </div>
          </div>

          <div class="hack-item">
            <div class="img-wrap">
              <a href="/6-popular-aesthetic-outfits-trends-for-2023-how-to-edit-your-ootd-photos/">
                <img src="/images/5.jpg" />
              </a>
              <div class="img-bg">
                <img src="/images/5.jpg" />
              </div>
            </div>

            <div class="feature">

              <a href="/category/creative-tips/">Creative Tips</a>

              <span class="dot">.</span>

              <a href="/category/features/">Features</a>

              <span class="dot">.</span>

              <a href="/category/trends/">Trends</a>

            </div>

            <div class="title">
              <a href="/6-popular-aesthetic-outfits-trends-for-2023-how-to-edit-your-ootd-photos/">
                6 Popular Aesthetic Outfits Trends for 2023 &amp; How to Edit Your OOTD Photos
              </a>
            </div>
          </div>

        </div>
      </div>
      <div class="btn-wrap">
        <a href="/editing-hacks/">More Hacks</a>
      </div>
    </section>

    <!-- 更多信息 -->
    <section class="more-info-wrap j-lazyrender j-revel" data-name="carousel">
      <div class="title">The Best Photo & Video Editor<br />You'll Ever Need</div>
      <div class="subtitle">Explore all filters, features, special effects, content, and more. Time to edit and
        improve your photos and videos using our easy-yet-powerful editing tools. Download SnapEditify for free, join
        premium to access all features and make your beauty plus now!</div>
      <div class="carousel-wrap">
        <div class="carousel-blocks">
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/001-144e67e8.jpg" />
                    <div class="img-desc">
                      Unlock over <span class="big">1,000</span> <br/>professional templates
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/002-7c640c9a.jpg" />
                    <div class="img-desc">
                      Unlimited use of over <br/><span class="big">7,000</span> premium stickers
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/003-cd28b664.jpg" />
                    <div class="img-desc">
                      Unlock over <span class="big">100</span> <br/>unique fonts
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/004-16e4bcd2.jpg" />
                    <div class="img-desc">
                      Boost your creativity <br/>with over <span class="big">100</span> premium brushes
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/005-e5b440a8.jpg" />
                    <div class="img-desc">
                      Enjoy over <span class="big">1,000</span> variety of filters
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/006-e80a85ee.jpg" />
                    <div class="img-desc">
                      Unlock cool patterns <br/>in Mosaic
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/007-026d0e60.jpg" />
                    <div class="img-desc">
                      Instantly cutout with <br/>Remove BG
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/008-6fca7518.jpg" />
                    <div class="img-desc">
                      Quickly remove unwanted <br/>objects using Remover
                    </div>
                  </div>
                </div>
                <!-- 轮播图复制一份 -->
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/001-144e67e8.jpg" />
                    <div class="img-desc">
                      Unlock over <span class="big">1,000</span> <br/>professional templates
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/002-7c640c9a.jpg" />
                    <div class="img-desc">
                      Unlimited use of over <br/><span class="big">7,000</span> premium stickers
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/003-cd28b664.jpg" />
                    <div class="img-desc">
                      Unlock over <span class="big">100</span> <br/>unique fonts
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/004-16e4bcd2.jpg" />
                    <div class="img-desc">
                      Boost your creativity <br/>with over <span class="big">100</span> premium brushes
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/005-e5b440a8.jpg" />
                    <div class="img-desc">
                      Enjoy over <span class="big">1,000</span> variety of filters
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/006-e80a85ee.jpg" />
                    <div class="img-desc">
                      Unlock cool patterns <br/>in Mosaic
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/007-026d0e60.jpg" />
                    <div class="img-desc">
                      Instantly cutout with <br/>Remove BG
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <div class="img-wrap">
                    <img src="/images/008-6fca7518.jpg" />
                    <div class="img-desc">
                      Quickly remove unwanted <br/>objects using Remover
                    </div>
                  </div>
                </div>
        </div>
      </div>
      <div class="info-wrap">
        <div class="info-item">
          <div class="item-title">75 million+</div>
          <div class="item-subtitle">Monthly active users</div>
        </div>
        <div class="info-item">
          <div class="item-title">800 million+</div>
          <div class="item-subtitle">Total installs around the world</div>
        </div>
        <div class="info-item">
          <div class="item-title">230 regions+</div>
          <div class="item-subtitle">User distribution around the world</div>
        </div>
        <div class="info-item">
          <div class="item-title">1.5 billion+</div>
          <div class="item-subtitle">Photos and videos generated per month</div>
        </div>
      </div>
      <div class="btn-wrap">
        <a class="try" data-loc="bottom" :href="$config.GET_APP_URL" target="_blank">Try It Now</a>
        <!-- <a data-loc="bottom"  target="_blank" class="download webDownload">
          Download
        </a> -->
      </div>
    </section>
  </div>

</template>

<script>
export default {
  name: 'home',
  layout: 'app',
  head: {
    script: [
      {
        src: "/js/home.js",
      },
    ]
  }
}
</script>
<style lang="">

</style>