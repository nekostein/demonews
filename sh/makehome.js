const fs = require('fs');
const ejs = require('ejs');


(async function () {
    const data = { LISTCONTENT: fs.readFileSync('.workdir/list.html').toString() };
    const html = await ejs.renderFile('wwwsrc/comp/home.ejs', data);
    console.log(html);
    fs.writeFileSync('wwwdist/index.html', html);
})();
