Solver for [minesweeper.online](https://minesweeper.online/)

To use install [minesweeper module](https://github.com/mrgriscom/minesweepr)

Run server with
```
python main.py
```
To run solver execute following snippet on minesweeper page
```js
function triggerMouseEvent(node, eventType) {
    var clickEvent = document.createEvent("MouseEvents");
    clickEvent.initEvent(eventType, true, true);
    node.dispatchEvent(clickEvent);
}
function click(xy) {
    e = document.getElementById(`cell_${xy}`);
    triggerMouseEvent(e, "mouseover");
    triggerMouseEvent(e, "mousedown");
    triggerMouseEvent(e, "mouseup");
    triggerMouseEvent(e, "click");
}
function getCell(cell) {
    if (cell.classList) {
        classList = Array.from(cell.classList);
        if (classList.includes("clear"))
            return -1;
        if (classList.includes("hd_closed"))
            return "x";
        for (let i = 0; i < 4; i++) {
            if (classList[i].startsWith("hd_type")) {
                if (classList[i].length == 9)
                    return "X";
                return classList[i].charAt(7);
            }
        }
    }
    return ""
}
function getBoard() {
    let res = [];
    let row = [];
    for (let el of document.getElementById("A43").children) {
        let x = getCell(el);
        if (x != -1)
            row.push(x);
        else {
            res.push(row);
            row = [];
        }
    }
    return res;
}
for (let i = 0; i < 1000; i++) {
    let pos = await fetch("http://localhost:5000/solve?" + new URLSearchParams({
        board: JSON.stringify(getBoard())
    }), {
        method: "GET"
    }).then(r => r.text());
    if (pos == "solved")
        break;
    click(pos);
}
```
