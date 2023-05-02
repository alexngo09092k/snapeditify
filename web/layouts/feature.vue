<template>
    <div class="container j-body">
        <app-header />
        <app-header-tab />
        <div id="j-featureCont" class="content">
            <nuxt />
            <app-footer />
        </div>
        <app-follow />
    </div>
</template>

<script>
import AppHeader from "../components/layout/app-header";
import AppHeaderTab from "../components/layout/app-header-tab";
import AppFooter from "../components/layout/app-footer";
import AppFollow from "../components/layout/app-follow";

export default {
    components: { AppHeader, AppHeaderTab, AppFooter, AppFollow },
    layout: "feature",
};
</script>
