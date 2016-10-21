module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 18,

    // font family with optional fallbacks
    fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#b2c89e',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BEAM',

    // color of the text
    foregroundColor: '#f2f4f7',

    // terminal background color
    backgroundColor: '#1C1F26',

    // border color (window, tabs)
    borderColor: '#1c1f26',

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: 'x-screen {letter-spacing: -.025em; -webkit-font-smoothing: antialiased;}',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '15px 15px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#1C1F26',
      red: '#CD777E',
      green: '#B2C89E',
      yellow: '#EFD39C',
      blue: '#9FB0C1',
      magenta: '#C2A1BB',
      cyan: '#A1B1C2',
      white: '#F2F4F7',
      lightBlack: '#686868',
      lightRed: '#CD777E',
      lightGreen: '#B2C89E',
      lightYellow: '#EFD39C',
      lightBlue: '#9FB0C1',
      lightMagenta: '#C2A1BB',
      lightCyan: '#A1B1C2',
      lightWhite: '#fff'
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '',

    // Set modifier keys so that alt can be used as a meta key
    modifierKeys: {
      altIsMeta: true
    },

    // for advanced config flags please refer to https://hyperterm.org/#cfg
    hyperline: {
      color: 'black',
      plugins: [
        {
          name: 'hostname',
          options: {
            color: 'lightBlue'
          }
        },
        {
          name: 'memory',
          options: {
            color: 'white'
          }
        },
        {
          name: 'uptime',
          options: {
            color: 'lightYellow'
          }
        },
        {
          name: 'cpu',
          options: {
            colors: {
              high: 'lightRed',
              moderate: 'lightYellow',
              low: 'lightGreen'
            }
          }
        },
        {
          name: 'network',
          options: {
            color: 'lightCyan'
          }
        },
        {
          name: 'battery',
          options: {
            colors: {
              fine: 'lightGreen',
              critical: 'lightRed'
            }
          }
        }
      ]
    }
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ["hyperterm-blink", "hyperterm-clicky", "hyperline"],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
