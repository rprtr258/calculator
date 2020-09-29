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
function click(elem) {
    e = document.getElementById(elem);
    triggerMouseEvent(e, "mouseover");
    triggerMouseEvent(e, "mousedown");
    triggerMouseEvent(e, "mouseup");
    triggerMouseEvent(e, "click");
}
function click_start() {
    e = document.querySelector(".hd_closed.start");
    triggerMouseEvent(e, "mouseover");
    triggerMouseEvent(e, "mousedown");
    triggerMouseEvent(e, "mouseup");
    triggerMouseEvent(e, "click");
}
function restart() {
    e = document.getElementById("top_area_face");
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
(async() => {
	let restarted = false;
	click_start();
    for (let i = 0; i < 100;i++) {
        while (true) {
            let pos = await fetch("http://localhost:5000/solve?" + new URLSearchParams({
                board: JSON.stringify(getBoard())
            }), {
                method: "GET"
            }).then(r => r.text());
            if (pos == "solved")
                break;
            click(`cell_${pos}`);
			restarted = false;
        }
		if (!restarted) {
			restart();
			restarted = true;
			click_start();
        }
    }
})();
```
Or save following bookmarklets:
[Solve board](javascript:function%28%29%7Bfunction%20triggerMouseEvent%28node%2C%20eventType%29%20%7Bvar%20clickEvent%20%3D%20document%2EcreateEvent%28%27MouseEvents%27%29%3BclickEvent%2EinitEvent%28eventType%2C%20true%2C%20true%29%3Bnode%2EdispatchEvent%28clickEvent%29%3B%7Dfunction%20click%28elem%29%20%7Be%20%3D%20document%2EgetElementById%28elem%29%3BtriggerMouseEvent%28e%2C%20%27mouseover%27%29%3BtriggerMouseEvent%28e%2C%20%27mousedown%27%29%3BtriggerMouseEvent%28e%2C%20%27mouseup%27%29%3BtriggerMouseEvent%28e%2C%20%27click%27%29%3B%7Dfunction%20getCell%28cell%29%20%7Bif%20%28cell%2EclassList%29%20%7BclassList%20%3D%20Array%2Efrom%28cell%2EclassList%29%3Bif%20%28classList%2Eincludes%28%27clear%27%29%29return%20%2D1%3Bif%20%28classList%2Eincludes%28%27hd%5Fclosed%27%29%29return%20%27x%27%3Bfor%20%28let%20i%20%3D%200%3B%20i%20%3C%204%3B%20i%2B%2B%29%20%7Bif%20%28classList%5Bi%5D%2EstartsWith%28%27hd%5Ftype%27%29%29%20%7Bif%20%28classList%5Bi%5D%2Elength%20%3D%3D%209%29return%20%27X%27%3Breturn%20classList%5Bi%5D%2EcharAt%287%29%3B%7D%7D%7Dreturn%20%22%22%7Dfunction%20getBoard%28%29%20%7Blet%20res%20%3D%20%5B%5D%3Blet%20row%20%3D%20%5B%5D%3Bfor%20%28let%20el%20of%20document%2EgetElementById%28%27A43%27%29%2Echildren%29%20%7Blet%20x%20%3D%20getCell%28el%29%3Bif%20%28x%20%21%3D%20%2D1%29row%2Epush%28x%29%3Belse%20%7Bres%2Epush%28row%29%3Brow%20%3D%20%5B%5D%3B%7D%7Dreturn%20res%3B%7D%28async%28%29%20%3D%3E%20%7Bfor%20%28let%20i%20%3D%200%3B%20i%20%3C%20100%3Bi%2B%2B%29%20%7Bwhile%20%28true%29%20%7Blet%20pos%20%3D%20await%20fetch%28%27http%3A%2F%2Flocalhost%3A5000%2Fsolve%3F%27%20%2B%20new%20URLSearchParams%28%7Bboard%3A%20JSON%2Estringify%28getBoard%28%29%29%7D%29%2C%20%7Bmethod%3A%20%27GET%27%7D%29%2Ethen%28r%20%3D%3E%20r%2Etext%28%29%29%3Bif%20%28pos%20%3D%3D%20%27solved%27%29break%3Bclick%28%60cell%5F%24%7Bpos%7D%60%29%3B%7D%7D%7D%29%28%29%3B%7D%28%29)
