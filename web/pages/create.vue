<template lang="">
    <div>
        <section class="tab-con ">
            <h2>Start design with...</h2>

            <ul class="tabs">
                <li class="tab j-tab active"><span>Picture</span></li>
                <li class="tab j-tab"><span>Blank Canvas</span></li>
                <li class="tab j-tab"><span>Recent Creation</span></li>
            </ul>
        </section>
        <section class="tab-content">
            <div class="each active j-cont">
                <p class="title">Select an image to start</p>
                <div class="cont-wrap type-pic">
                    <div class="upload-pic j-uploadPic">
                        <span class="tips">Drag the image here or tap to upload the image</span>
                        <label for="file">
                            <span>Upload</span>
                            <input type="file" id="file" name="file" class="j-file"
                                accept="image/png,image/jpg,image/jpeg" />
                        </label>
                    </div>
                    <ul class="try j-sampleList"></ul>
                </div>
            </div>
            <div class="each j-cont">
                <p class="title">Create a blank canvas to start</p>
                <div class="cont-wrap type-canvas">
                    <ul class="size-list j-sizeList"></ul>
                    <div class="custom-input">
                        <input type="text" maxlength="5" placeholder="Width" class="j-width" />
                        <span class="cross"></span>
                        <input type="text" maxlength="5" placeholder="Height" class="j-height" />
                        <span>px</span>
                        <button disabled class="j-confirm">Custom</button>
                    </div>
                </div>
            </div>
            <div class="each j-cont">
                <p class="title">
                    Select a recent creation to start
                </p>
                <div class="cont-wrap type-work">

                    <div class="empty-work no-login">
                        <p>Log in to view recent creations</p>
                        <button class="j-login">Log in</button>
                    </div>

                </div>
            </div>
        </section>
    </div>

</template>
<script>
export default {
    name: 'create',
    layout: 'app',
    head: {
        link: [
            {
                rel: "stylesheet",
                href: "/css/create.css",
            },
        ],
        script: [
            {
                src: "/js/create.js",
                defer: true,
            },
        ]
    }
}
</script>