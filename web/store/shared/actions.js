async function set$Config({ commit }, $config) {
  /// must call before use other function
  commit("SET_$CONFIG", $config);
}

const actions = {
  set$Config,
};

export default actions;
