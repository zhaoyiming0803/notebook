const vm = require('vm');
const fs = require('fs');

const templateMap = {
  index: '`' + fs.readFileSync('./index.tpl').toString() + '`',
  title: '`' + fs.readFileSync('./title.tpl').toString() + '`',
  content: '`' + fs.readFileSync('./content.tpl').toString() + '`',
  tag: '`' + fs.readFileSync('./tag.tpl').toString() + '`',
};

const context = {
  name: 'zhaoyiming',
  age: 18,
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

  include: function (key) {
    return templateMap[key]();
  }
}

Object.keys(templateMap).forEach(key => {
  const temp = templateMap[key];
  templateMap[key] = vm.runInNewContext(`() => ${temp}`, context);
});

fs.writeFile('index.html', templateMap.index(), error => {
  console.log(error);
});
