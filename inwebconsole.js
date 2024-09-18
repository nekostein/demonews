// Run script at: 'https://steamdb.info/upcoming/?lastweek'



(function () {
    const output_text = [].map.call(document.querySelectorAll('tr.app'), function (tr_node) {
        const appid = tr_node.getAttribute('data-appid');
        const date = tr_node.querySelector('td:nth-child(7)').getAttribute('data-sort');
        const title = tr_node.querySelector('td:nth-child(3) a.b').innerText;
        const type = tr_node.querySelector('td:nth-child(3) span.cat').innerText;
        return [type, date, appid, title];
    }).filter(arr => arr[0] === 'Demo').map(arr => arr.slice(1).join('^')).join('\n');
    console.log(output_text);
    copy(output_text);
    // Get clipboard content: xclip -selection clipboard -o
})();
