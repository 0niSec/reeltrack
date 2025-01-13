const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    container: {
      center: true,
    },
    extend: {
      colors: {
        primary: {
          50: "#fdf3f3",
          100: "#fce4e4",
          200: "#facece",
          300: "#f6abab",
          400: "#ef7a7a",
          500: "#e35050",
          600: "#d03232",
          700: "#a22424",
          800: "#902424",
          900: "#782424",
          950: "#410e0e",
        },
      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ],
};
