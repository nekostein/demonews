// Run script at: 'https://steamdb.info/upcoming/?lastweek'



(function () {
    let output_text_arr = [];
    document.querySelectorAll('tr.app').forEach(function (tr_node) {
        try {
            const appid = tr_node.getAttribute('data-appid');
            console.log(`appid = ${appid}`);
            console.log(`tr.app[data-appid="${appid}"] td:nth-child(7)`);
            const date = document.querySelector(`tr.app[data-appid="${appid}"] td:nth-child(7)`).getAttribute(`data-sort`);
            const title = document.querySelector(`tr.app[data-appid="${appid}"] td:nth-child(3) a.b`).innerText;
            const type = document.querySelector(`tr.app[data-appid="${appid}"] td:nth-child(3) span.cat`).innerText;
            if (type === 'Demo') {
                output_text_arr.push([type, date, appid, title])
            };
        }catch(e){
        }
    })
    const output_text = output_text_arr.map(arr => arr.slice(1).join('^')).join('\n');
    console.log(output_text_arr);
    console.log(output_text);
    copy(output_text);
    // Get clipboard content: xclip -selection clipboard -o
})();
