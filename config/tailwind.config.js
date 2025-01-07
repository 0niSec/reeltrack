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
      fontFamily: {
        sans: ["Noto Sans", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: {
          DEFAULT: "#0EA5E9",
          50: "#B4E5FA",
          100: "#A1DEF9",
          200: "#7AD0F7",
          300: "#54C3F5",
          400: "#2DB5F2",
          500: "#0EA5E9",
          600: "#0B80B4",
          700: "#085A7F",
          800: "#04354A",
          900: "#010F15",
          950: "#000000",
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
