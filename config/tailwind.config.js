const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
	  colors: {
		  darkgreen: '#009e60',
		  lightgreen: '#80bd01',
		  fluogreen: '#00f57c',
		  marinegreen: '#09b876',
		  grapeblack: '#3B2D3D',
		  isabellinewhite: '#F8F6F2',
		  razzmicberry: '#704572'
	  }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
