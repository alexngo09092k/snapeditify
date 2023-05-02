<template>
    <div class="container j-body">
        <app-header />
        <app-header-tab />
        <div id="j-mainCont" class="content">
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
import { mapActions } from 'vuex';

export default {
    components: { AppHeader, AppHeaderTab, AppFooter, AppFollow },
    layout: "app",
    methods: {
        ...mapActions({
            initial: 'shared/set$Config',
        }),
    },
    mounted() {
        this.initial();
    }
};
</script>
