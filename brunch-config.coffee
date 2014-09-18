exports.config =

  plugins:
    appcache:
      network: ['*']
      fallback: {}

  paths:
    public: 'public'

  files:
    javascripts:
      defaultExtension: 'coffee'

      order:
        before: [
          /^bower_components\//
        ]

      joinTo:
        'js/app.js': /^(app|bower_components)\//

    stylesheets:
      defaltExtension: 'sass'

      order:
        before: [
          /^bower_components\//
        ]

      joinTo:
        'css/styles.css': /^(app|bower_components)\//


