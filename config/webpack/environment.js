const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

// So we can load in jquery and popper plugins for use with Bootstrap.
var plugin_list = {
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}

var webpack_plugins = new webpack.ProvidePlugin(plugin_list)
environment.plugins.append("Provide", webpack_plugins)

module.exports = environment
