const vm = require('vm');

const article = {
  title: 'article title',
  content: 'article content <script>alert("danger...");</script> ...'
};

const template = '`<h1>${article.title}</h1><div>${xss(article.content)}</div>`';
console.log(template)
const htmlContent = vm.runInNewContext(template, {
  article,

  helper (str) {
    // ...
    return str;
  },
  
  xss (str) {
    if (!str) return '';
    return str.toString()
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&quot;');
  }
})

console.log(htmlContent);