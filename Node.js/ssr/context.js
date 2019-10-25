const fs = require('fs');

const context = module.exports = {
  xss: function (str) {
    if (!str) return '';
    return str.toString()
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&quot;');
  },

  include: (function () {
    const cache = {};
    return function (templatePath) {
      return cache[templatePath] || (cache[templatePath] = fs.readFileSync(templatePath).toString());
    }
  })()
}