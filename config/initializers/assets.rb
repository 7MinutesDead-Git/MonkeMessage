# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Precompile additional assets.
# application.js, application.css.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( card_reveal.js custom.css.scss )

# https://github.com/sass/sassc-rails/issues/6
# Rails.application.config.assets.configure do |env|
#   env.register_mime_type 'text/css', extensions: ['.scss'], charset: :css
#   env.register_mime_type 'text/css', extensions: ['.css.scss'], charset: :css
#   env.register_preprocessor 'text/css', SassC::Rails::ScssTemplate
# end